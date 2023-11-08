unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons;

type
  TForm1 = class(TForm)
    pnlTopo: TPanel;
    btPrecos: TSpeedButton;
    ImageList: TImageList;
    btTanques: TSpeedButton;
    btBombas: TSpeedButton;
    btAbastecer: TSpeedButton;
    btRelatorio: TSpeedButton;
    procedure btPrecosClick(Sender: TObject);
    procedure btBombasClick(Sender: TObject);
    procedure btTanquesClick(Sender: TObject);
    procedure btAbastecerClick(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uPrecos, uTanques, uBombas, uMovimento, uRelatorios;

procedure TForm1.btAbastecerClick(Sender: TObject);
begin
  if not Assigned(fMovimento) then
    Application.CreateForm(TfMovimento, fMovimento);
  fMovimento.ShowModal;
  FreeAndNil(fMovimento);
end;

procedure TForm1.btBombasClick(Sender: TObject);
begin
  if not Assigned(fBombas) then
    Application.CreateForm(TfBombas, fBombas);
  fBombas.ShowModal;
  FreeAndNil(fBombas);
end;

procedure TForm1.btPrecosClick(Sender: TObject);
begin
  if not Assigned(fPrecos) then
    Application.CreateForm(TfPrecos, fPrecos);
  fPrecos.ShowModal;
  FreeAndNil(fPrecos);
end;

procedure TForm1.btRelatorioClick(Sender: TObject);
begin
  if not Assigned(fRelatorios) then
    Application.CreateForm(TfRelatorios, fRelatorios);
  fRelatorios.ShowModal;
  FreeAndNil(fRelatorios);
end;

procedure TForm1.btTanquesClick(Sender: TObject);
begin
  if not Assigned(fTanques) then
    Application.CreateForm(TfTanques, fTanques);
  fTanques.ShowModal;
  FreeAndNil(fTanques);
end;

end.
