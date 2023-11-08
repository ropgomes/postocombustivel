unit uPrecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, clPrecos, PrecosBLL;

type
  TfPrecos = class(TForm)
    ImageList: TImageList;
    btCancelar: TSpeedButton;
    btSalvar: TSpeedButton;
    btNovo: TSpeedButton;
    rgVigente: TRadioGroup;
    edtVlrLitroOle: TEdit;
    lblVlrLitroOle: TLabel;
    edtVlrLitroGas: TEdit;
    lblVlrLitroGas: TLabel;
    edtId: TEdit;
    lblCodigo: TLabel;
    lblVlrImposto: TLabel;
    edtVlrImposto: TEdit;
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObterPrecos;
  end;

var
  fPrecos: TfPrecos;

implementation

{$R *.dfm}

procedure TfPrecos.btNovoClick(Sender: TObject);
begin
  try
    edtId.Text := EmptyStr;
    edtVlrLitroGas.Text := EmptyStr;
    edtVlrLitroOle.Text := EmptyStr;
    edtVlrImposto.Text := EmptyStr;
    rgVigente.ItemIndex := -1;
  except on E: Exception do
    begin
      MessageBox(0, PWideChar(E.Message),'Atenção',MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfPrecos.btSalvarClick(Sender: TObject);
var
  PrecosBLL : TPrecosBLL;
  Precos : TPrecos;
begin
  try
    PrecosBLL := TPrecosBLL.Create;
    Precos := TPrecos.Create;
    Precos.Id := 0;
    Precos.VlrLitroGas := StrToFloat(edtVlrLitroGas.Text);
    Precos.VlrLitroOle := StrToFloat(edtVlrLitroOle.Text);
    Precos.VlrImposto := StrToFloat(edtVlrImposto.Text);
    if rgVigente.ItemIndex = 0 then
      Precos.Vigente := 1
    else
      Precos.Vigente := 0;
    PrecosBLL.Salvar(Precos);
    ObterPrecos;
    MessageBox(0, PWideChar('Dados salvos com sucesso!'),'Atenção',MB_OK + MB_ICONEXCLAMATION);
  except
    on E: Exception do
      MessageBox(0, PWideChar(E.Message),'Atenção',MB_OK + MB_ICONERROR);
  end;
end;

procedure TfPrecos.FormShow(Sender: TObject);
begin
  ObterPrecos;
end;

procedure TfPrecos.ObterPrecos;
var
  PrecosBLL : TPrecosBLL;
  Precos : TPrecos;
begin
  try
    PrecosBLL := TPrecosBLL.Create;
    Precos := PrecosBLL.ObterPrecos;
    if Assigned(Precos) then
    begin
      edtId.Text := IntToStr(Precos.Id);
      edtVlrLitroGas.Text := FormatFloat('#,##0.00',Precos.VlrLitroGas);
      edtVlrLitroOle.Text := FormatFloat('#,##0.00',Precos.VlrLitroOle);
      edtVlrImposto.Text := FormatFloat('#,##0.00',Precos.VlrImposto);
      if (Precos.Vigente = 1) then
        rgVigente.ItemIndex := 0
      else
        rgVigente.ItemIndex := 1;
    end;
  except
    on E: Exception do
      MessageBox(0, PWideChar(E.Message),'Atenção',MB_OK + MB_ICONERROR);
  end;
end;

end.
