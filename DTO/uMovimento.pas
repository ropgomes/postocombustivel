unit uMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, clTanque, TanqueBLL, clBomba, BombaBLL,
  clPrecos, PrecosBLL, clMovimento, MovimentoBLL;

type
  TfMovimento = class(TForm)
    ImageList: TImageList;
    lblBombas: TLabel;
    cbBomba: TComboBox;
    lblLitros: TLabel;
    edtLitros: TEdit;
    lblValor: TLabel;
    edtValor: TEdit;
    lblVlrLitro: TLabel;
    edtVlrLitro: TEdit;
    btNovo: TSpeedButton;
    btSalvar: TSpeedButton;
    btCancelar: TSpeedButton;
    procedure edtLitrosChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure cbBombaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vVlrLitroGas : Double;
    vVlrLitroOle : Double;
    vVlrImposto : Double;
    vBomba : TBomba;
  public
    { Public declarations }
    procedure ObterBombas;
    procedure ObterPrecos;
    procedure TrataEventos(ativo : Boolean);
    function ValidaBomba : Boolean;
  end;

var
  fMovimento: TfMovimento;

implementation

{$R *.dfm}

procedure TfMovimento.btCancelarClick(Sender: TObject);
begin
  TrataEventos(False);
end;

procedure TfMovimento.btNovoClick(Sender: TObject);
begin
  TrataEventos(True);
end;

procedure TfMovimento.btSalvarClick(Sender: TObject);
var
  MovimentoBLL : TMovimentoBLL;
  Movimento : TMovimento;
  BombaBLL : TBombaBLL;
begin
  try
    MovimentoBLL := TMovimentoBLL.Create;
    Movimento := TMovimento.Create;
    BombaBLL := TBombaBLL.Create;

    Movimento.Id := 0;
    Movimento.Litros := StrToFloat(edtLitros.Text);
    Movimento.DtHr := FormatDateTime('DD/MM/YYYY', Now);
    Movimento.VlrTotal := StrToFloat(edtValor.Text);
    Movimento.VlrImposto := ((vVlrImposto * StrToFloat(edtValor.Text)) / 100);
    Movimento.Bomba := BombaBLL.ObterBombaPorId(StrToInt(Trim(Copy(cbBomba.Text, 0,
                                                Pos('-',cbBomba.Text) - 1))));
    MovimentoBLL.Salvar(Movimento);

    MessageBox(0, PWideChar('Dados salvos com sucesso!'),'Aten��o',MB_OK + MB_ICONEXCLAMATION);
    TrataEventos(False);
    FreeAndNil(MovimentoBLL);
    FreeAndNil(Movimento);
    FreeAndNil(BombaBLL);
  except
    on E: Exception do
      MessageBox(0, PWideChar(E.Message),'Aten��o',MB_OK + MB_ICONERROR);
  end;
end;

procedure TfMovimento.cbBombaChange(Sender: TObject);
begin
  ObterPrecos;
end;

procedure TfMovimento.edtLitrosChange(Sender: TObject);
begin
  if ValidaBomba and (Trim(edtLitros.Text) <> '') then
  begin
    if vBomba.Tanque.Tipo = ttGasolina then
      edtValor.Text := FormatFloat('#,##0.00', vVlrLitroGas * StrToFloat(edtLitros.Text))
    else
      edtValor.Text := FormatFloat('#,##0.00',vVlrLitroOle * StrToFloat(edtLitros.Text));
  end;
end;

procedure TfMovimento.edtValorChange(Sender: TObject);
begin
  if ValidaBomba and (Trim(edtValor.Text) <> '') then
  begin
    if vBomba.Tanque.Tipo = ttGasolina then
      edtLitros.Text := FormatFloat('#,##0.00', StrToFloat(edtValor.Text) / vVlrLitroGas)
    else
      edtLitros.Text := FormatFloat('#,##0.00', StrToFloat(edtValor.Text) / vVlrLitroOle);
  end;
end;

procedure TfMovimento.FormShow(Sender: TObject);
begin
  ObterBombas;
  TrataEventos(False);
end;

procedure TfMovimento.ObterBombas;
var
  BombaBLL : TBombaBLL;
  Query : TFDQuery;
begin
  try
    BombaBLL := TBombaBLL.Create;
    Query := BombaBLL.ObterBombas('*');

    if Assigned(Query) then
    begin

      Query.First;
      while not Query.Eof do
      begin
        cbBomba.Items.Add(Query.Fields[0].AsString + ' - ' + Query.Fields[1].AsString);
        Query.Next;
      end;
    end;

    FreeAndNil(BombaBLL);
    FreeAndNil(Query);
  except on E: Exception do
    begin
      MessageBox(0, PWideChar(E.Message),'Aten��o',MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfMovimento.ObterPrecos;
var
  PrecosBLL : TPrecosBLL;
  BombaBLL : TBombaBLL;
  Precos : TPrecos;
  Bomba : TBomba;
begin
  try
    if cbBomba.ItemIndex >= 0 then
    begin
      PrecosBLL := TPrecosBLL.Create;
      BombaBLL := TBombaBLL.Create;

      Precos := PrecosBLL.ObterPrecos;
      vVlrLitroGas := Precos.VlrLitroGas;
      vVlrLitroOle := Precos.VlrLitroOle;
      vVlrImposto := Precos.VlrImposto;

      Bomba := BombaBLL.ObterBombaPorId(StrToInt(Trim(Copy(cbBomba.Text, 0,
                                                  Pos('-',cbBomba.Text) - 1))));

      vBomba := Bomba;

      if Bomba.Tanque.Tipo = ttGasolina then
        edtVlrLitro.Text := FormatFloat('#,##0.00',Precos.VlrLitroGas)
      else
        edtVlrLitro.Text := FormatFloat('#,##0.00',Precos.VlrLitroOle);
    end;
  except
    on E: Exception do
      MessageBox(0, PWideChar(E.Message),'Aten��o',MB_OK + MB_ICONERROR);
  end;
end;

procedure TfMovimento.TrataEventos(ativo: Boolean);
begin
  cbBomba.Enabled := ativo;
  edtLitros.Enabled := ativo;
  edtValor.Enabled := ativo;
  edtVlrLitro.Enabled := ativo;
  if not ativo then
  begin
    edtLitros.Text := EmptyStr;
    edtValor.Text := EmptyStr;
    edtVlrLitro.Text := EmptyStr;
  end;
end;

function TfMovimento.ValidaBomba: Boolean;
begin
  Result := True;
  if cbBomba.ItemIndex <= -1 then
  begin
    MessageBox(0, 'Selecionar uma Bomba!','Aten��o',MB_OK + MB_ICONEXCLAMATION);
    Result := False;
  end;
end;

end.
