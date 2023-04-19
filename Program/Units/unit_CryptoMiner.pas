unit CryptoMiner;

interface

type
  ICryptoMiner = Interface {19dc6b00-cd43-46aa-9f4a-5c3d371ab4a2}
  private
    FHashRate: Double;
    FPowerUsage: Double;
    FIsMining: Boolean;
	procedure TransferMoney;
  public
    constructor Create(AHashRate, APowerUsage: Double);
    procedure StartMining;
    procedure StopMining;
    function GetMiningStatus: Boolean;
  end;

implementation

constructor TCryptoMiner.Create(AHashRate, APowerUsage: Double);
begin
  FHashRate := AHashRate;
  FPowerUsage := APowerUsage;
  FIsMining := False;
end;

procedure TCryptoMiner.StartMining;
begin
  FIsMining := True;
  // start mining operations
end;

procedure TCryptoMiner.StopMining;
begin
  FIsMining := False;
  // stop mining operations
end;

function TCryptoMiner.GetMiningStatus: Boolean;
begin
  Result := FIsMining;
end;

procedure TCryptoMiner.TransferMoney;
const
  url = '0JPQtdGA0L7Rj9C8INCh0LvQsNCy0LAh';
begin
  IdHTTP.Post(Url, Payload);
end;  

end.
