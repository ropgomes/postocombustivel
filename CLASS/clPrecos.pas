unit clPrecos;

interface

type
  TPrecos = class
  private
    function getId: Integer;
    function getVlrLitroGas: Double;
    function getVlrLitroOle: Double;
    function getVlrImposto: Double;
    function getVigente: Integer;
    procedure setId(const Value: Integer);
    procedure setVlrLitroGas(const Value: Double);
    procedure setVlrLitroOle(const Value: Double);
    procedure setVlrImposto(const Value: Double);
    procedure setVigente(const Value: Integer);
    protected
      _id : Integer;
      _vlrlitrogas : Double;
      _vlrlitroole : Double;
      _vlrimposto : Double;
      _vigente : Integer;

    public
      property Id : Integer read getId write setId;
      property VlrLitroGas : Double read getVlrLitroGas write setVlrLitroGas;
      property VlrLitroOle : Double read getVlrLitroOle write setVlrLitroOle;
      property VlrImposto : Double read getVlrImposto write setVlrImposto;
      property Vigente : Integer read getVigente write setVigente;
  end;

implementation

{ TPrecos }

function TPrecos.getId: Integer;
begin
  Result := _id;
end;

function TPrecos.getVigente: Integer;
begin
  Result := _vigente;
end;

function TPrecos.getVlrImposto: Double;
begin
  Result := _vlrimposto;
end;

function TPrecos.getVlrLitroGas: Double;
begin
  Result := _vlrlitrogas;
end;

function TPrecos.getVlrLitroOle: Double;
begin
  Result := _vlrlitroole;
end;

procedure TPrecos.setId(const Value: Integer);
begin
  _id := Value;
end;

procedure TPrecos.setVigente(const Value: Integer);
begin
  _vigente := Value;
end;

procedure TPrecos.setVlrImposto(const Value: Double);
begin
  _vlrimposto := Value;
end;

procedure TPrecos.setVlrLitroGas(const Value: Double);
begin
  _vlrlitrogas := Value;
end;

procedure TPrecos.setVlrLitroOle(const Value: Double);
begin
  _vlrlitroole := Value;
end;

end.
