program PostoCombustivel;

uses
  Vcl.Forms,
  uPrincipal in 'DTO\uPrincipal.pas' {Form1},
  clMovimento in 'CLASS\clMovimento.pas',
  clPrecos in 'CLASS\clPrecos.pas',
  clBomba in 'CLASS\clBomba.pas',
  clTanque in 'CLASS\clTanque.pas',
  MovimentoDAO in 'DAO\MovimentoDAO.pas',
  BombaDAO in 'DAO\BombaDAO.pas',
  TanqueDAO in 'DAO\TanqueDAO.pas',
  PrecosDAO in 'DAO\PrecosDAO.pas',
  ConexaoDAO in 'DAO\ConexaoDAO.pas',
  BombaBLL in 'BLL\BombaBLL.pas',
  TanqueBLL in 'BLL\TanqueBLL.pas',
  PrecosBLL in 'BLL\PrecosBLL.pas',
  MovimentoBLL in 'BLL\MovimentoBLL.pas',
  uBombas in 'DTO\uBombas.pas' {fBombas},
  uTanques in 'DTO\uTanques.pas' {fTanques},
  uPrecos in 'DTO\uPrecos.pas' {fPrecos},
  uMovimento in 'DTO\uMovimento.pas' {fMovimento},
  uRelatorios in 'DTO\uRelatorios.pas' {fRelatorios},
  RelatorioDAO in 'DAO\RelatorioDAO.pas',
  RelatoriosBLL in 'BLL\RelatoriosBLL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfBombas, fBombas);
  Application.CreateForm(TfTanques, fTanques);
  Application.CreateForm(TfPrecos, fPrecos);
  Application.CreateForm(TfMovimento, fMovimento);
  Application.CreateForm(TfMovimento, fMovimento);
  Application.CreateForm(TfRelatorios, fRelatorios);
  Application.Run;
end.
