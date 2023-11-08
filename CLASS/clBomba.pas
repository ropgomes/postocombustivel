unit clBomba;

interface

uses clTanque;

type
  TBomba = class
  private
    function getDescricao: String;
    function getId: Integer;
    function getTanque: TTanque;
    procedure setDescricao(const Value: String);
    procedure setId(const Value: Integer);
    procedure setTanque(const Value: TTanque);
    protected
      _id : Integer;
      _descricao : String;
      _tanque : TTanque;

    public
      property Id : Integer read getId write setId;
      property Descricao : String read getDescricao write setDescricao;
      property Tanque : TTanque read getTanque write setTanque;
  end;

implementation

{ TBomba }

function TBomba.getDescricao: String;
begin
  Result := _descricao;
end;

function TBomba.getId: Integer;
begin
  Result :=  _id;
end;

function TBomba.getTanque: TTanque;
begin
  Result := _tanque;
end;

procedure TBomba.setDescricao(const Value: String);
begin
  _descricao := Value;
end;

procedure TBomba.setId(const Value: Integer);
begin
  _id := Value;
end;

procedure TBomba.setTanque(const Value: TTanque);
begin
  _tanque := Value;
end;

end.

