unit clTanque;

interface

type
  TTipoTanque = (ttGasolina, ttOleo);

  TTanque = class
  private
    function getCapacidade: Double;
    function getDescricao: String;
    function getId: Integer;
    function getTipo: TTipoTanque;
    procedure setCapacidade(const Value: Double);
    procedure setDescricao(const Value: String);
    procedure setId(const Value: Integer);
    procedure setTipo(const Value: TTipoTanque);
    protected
      _id : Integer;
      _descricao : String;
      _capacidade : Double;
      _tipo : TTipoTanque;

    public
      property Id : Integer read getId write setId;
      property Descricao : String read getDescricao write setDescricao;
      property Capacidade : Double read getCapacidade write setCapacidade;
      property Tipo : TTipoTanque read getTipo write setTipo;
  end;

implementation

{ TTanque }

function TTanque.getCapacidade: Double;
begin
  Result := _capacidade;
end;

function TTanque.getDescricao: String;
begin
  Result := _descricao;
end;

function TTanque.getId: Integer;
begin
  Result :=  _id;
end;

function TTanque.getTipo: TTipoTanque;
begin
  Result := _tipo;
end;

procedure TTanque.setCapacidade(const Value: Double);
begin
  _capacidade := Value;
end;

procedure TTanque.setDescricao(const Value: String);
begin
  _descricao := Value;
end;

procedure TTanque.setId(const Value: Integer);
begin
  _id := Value;
end;

procedure TTanque.setTipo(const Value: TTipoTanque);
begin
  _tipo := Value;
end;

end.
