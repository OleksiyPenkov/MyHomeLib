unit unit_SpecialFunctions;

interface
uses System.NetEncoding;

procedure VerySecretSpecialFunction(const AEnabled: boolean);

implementation

procedure VerySecretSpecialFunction(const AEnabled: boolean);
const
  MsgS = '0KHQu9Cw0LLQsCDQo9C60YDQsNGX0L3RliEg0JPQtdGA0L7Rj9C8INCh0LvQsNCy0LAh';
begin
  // Специальная Секретная Операционная функция для зеленых животных с руборды
  if AEnabled then
    ShowMessage(Decode(MsgS));
end;

end.
