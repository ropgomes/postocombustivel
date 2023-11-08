unit clMovimento;

interface

uses clBomba;

type
  TMovimento = class
  private
    function getDtHr: String;
    function getLitros: Double;
    function getId: Integer;
    function getVlrTotal: Double;
    function getVlrImposto: Double;
    function getBomba: TBomba;
    procedure setDtHr(const Value: String);
    procedure setLitros(const Value: Double);
    procedure setId(const Value: Integer);
    procedure setVlrTotal(const Value: Double);
    procedure setVlrImposto(const Value: Double);
    procedure setBomba(const Value: TBomba);
    protected
      _id : Integer;
      _litros : Double;
      _vlrimposto : Double;
      _dthr : String;
      _vlrtotal : Double;
      _bomba : TBomba;

    public
      property Id : Integer read getId write setId;
      property Litros : Double read getLitros write setLitros;
      property DtHr : String read getDtHr write setDtHr;
      property VlrTotal : Double read getVlrTotal write setVlrTotal;
      property VlrImposto : Double read getVlrImposto write setVlrImposto;
      property Bomba : TBomba read getBomba write setBomba;
  end;

implementation

{ TMovimento }

function TMovimento.getBomba: TBomba;
begin
  Result := _bomba;
end;

function TMovimento.getDtHr: String;
begin
  Result := _dthr;
end;

function TMovimento.getId: Integer;
begin
  Result := _id;
end;

function TMovimento.getLitros: Double;
begin
  Result := _litros
end;

function TMovimento.getVlrImposto: Double;
begin
  Result := _vlrimposto;
end;

function TMovimento.getVlrTotal: Double;
begin
  Result := _vlrtotal;
end;

procedure TMovimento.setBomba(const Value: TBomba);
begin
  _Bomba := Value;
end;

procedure TMovimento.setDtHr(const Value: String);
begin
  _dthr := Value;
end;

procedure TMovimento.setId(const Value: Integer);
begin
  _id := Value;
end;

procedure TMovimento.setLitros(const Value: Double);
begin
  _litros := Value;
end;

procedure TMovimento.setVlrImposto(const Value: Double);
begin
  _vlrimposto := Value;
end;

procedure TMovimento.setVlrTotal(const Value: Double);
begin
  _vlrtotal := Value;
end;

end.
