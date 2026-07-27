unit unit_MCP_Fixture;

interface

// Builds a small throwaway collection so the protocol suite in tests/cases
// stops depending on whatever library the machine happens to have.
//
// This mode contains NO path logic of its own. It is invoked as
//
//   MHLMcpServer.exe --make-fixture uselocaldata user mcpfixture
//
// and the server under test is later started as
//
//   MHLMcpServer.exe uselocaldata user mcpfixture
//
// TMHLSettings.Create scans the raw command line in BOTH processes
// (unit_Settings.pas:513-534), so both compute the same
// <exedir>\Data\mcpfixture.dbs. The fixture is therefore created exactly
// where the server under test will look for it, by construction rather than
// by agreement.
//
// mcpfixture.dbs / mcpfixture.ini do not collide with the real user.dbs2 /
// myhomelib2.ini in the same folder, so a developer's dev library in
// Program\OUT\Bin64 survives a test run untouched.
//
// Unlike --extract and --cache-selftest, this mode needs DMUser and so runs
// AFTER Application.Initialize. See the dispatch in MHLMcpServer.dpr.
procedure RunMakeFixtureMode;

const
  // The `user <name>` switch value the harness passes. Named here so the
  // README, the tests and this unit cannot drift apart.
  FIXTURE_USER_NAME = 'mcpfixture';

  FIXTURE_DISPLAY_NAME = 'MCP Fixture';

  // Book folder inside the collection root. The trailing separator is NOT
  // cosmetic: TBookRecord.GetBookFormat (unit_Globals.pas:993) only classifies
  // a row as bfFb2 when the container path is empty or ends in a separator.
  // Without it every fixture book degrades to bfRaw and the text tools refuse
  // it.
  FIXTURE_FOLDER = 'books\';

implementation

uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  dm_user,
  unit_Settings,
  unit_Globals,
  unit_Consts,
  unit_Interfaces,
  unit_MCP_Transport;

// A private, local, FB2 collection. CONTENT_FB, LIBRARY_PRIVATE and
// LOCATION_LOCAL are all $00000000 (unit_Consts.pas:240-252), so the code is
// simply 0 -- spelled out rather than hard-coded so the intent survives.
const
  FIXTURE_COLLECTION_TYPE = CONTENT_FB or LIBRARY_PRIVATE or LOCATION_LOCAL;

procedure RunMakeFixtureMode;
var
  DbFileName: string;
  RootFolder: string;
  CollectionFile: string;
  CollectionID: Integer;
  Summary: TJSONObject;
  Transport: TMcpTransport;
begin
  if not Assigned(DMUser) then
    DMUser := TDMUser.Create(nil);

  DbFileName := DMUser.Settings.SystemFileName[sfSystemDB];
  RootFolder := TPath.Combine(ExtractFilePath(ParamStr(0)), FIXTURE_USER_NAME);
  CollectionFile := TPath.Combine(RootFolder, FIXTURE_USER_NAME + '.hlc2');

  // Wipe first. This is what makes the ids deterministic: a fresh system
  // database always hands the first registered collection id 1, and a fresh
  // collection always numbers books from 1 in insertion order. Every
  // expectation in tests/cases depends on that.
  if TFile.Exists(DbFileName) then
    TFile.Delete(DbFileName);
  if TDirectory.Exists(RootFolder) then
    TDirectory.Delete(RootFolder, True);
  TDirectory.CreateDirectory(RootFolder);

  // With the system database file absent, Init takes its create-if-missing
  // branch (TSystemData_SQLite.CreateSystemTables) -- the one branch
  // EnsureLibraryInitialized deliberately refuses to reach in server mode.
  // Here it is exactly what is wanted.
  DMUser.Init;

  CollectionID := SystemDB.CreateCollection(
    FIXTURE_DISPLAY_NAME,
    RootFolder,
    CollectionFile,
    FIXTURE_COLLECTION_TYPE,
    DMUser.Settings.SystemFileName[sfGenresFB2]
  );

  if CollectionID <> 1 then
    raise Exception.CreateFmt(
      'Fixture collection was registered as id %d, expected 1. ' +
      'The previous system database at %s was not removed.',
      [CollectionID, DbFileName]);

  Summary := TJSONObject.Create;
  try
    Summary.AddPair('collection_id', TJSONNumber.Create(CollectionID));
    Summary.AddPair('root', RootFolder);
    Summary.AddPair('db', DbFileName);
    Summary.AddPair('books', TJSONArray.Create);

    Transport := TMcpTransport.Create;
    try
      Transport.WriteMessage(Summary.ToJSON);
    finally
      Transport.Free;
    end;
  finally
    Summary.Free;
  end;
end;

end.
