create table empresa(
idEmpresa int primary key auto_increment,
nome varchar(80),
cnpj char(14),
cep char(8),
numero varchar(45),
complemento varchar(45),
email varchar(80),
senha varchar(50)
);

create table usuario(
idUsuario int auto_increment,
nome varchar(80),
cpf char(11),
sn varchar(50),
email varchar(50),
senha varchar(50),
fkEmpresa int,
primary key(idUsuario)
);

create table maquina(
idMaquina int not null auto_increment, 
hostName varchar(150),
fkUsuario int,
fkEmpresa int,
primary key(idMaquina)
);

create table componente(
idComponente int auto_increment,
nomeComponente varchar(150),
primary key(idComponente)
);

create table componenteMaquina(
idComponenteMaquina int auto_increment,
totalComponente varchar(150),
unidadeMedida varchar(150),
fkComponente int,
fkMaquina int,
primary key(idComponenteMaquina)
);

create table registroComponente(
idRegistroComponente int auto_increment,
dataHora varchar(150),
consumo varchar(150),
fkComponenteMaquina int,
primary key(idRegistroComponente)
);

create table programa(
idPrograma int auto_increment,
nomePrograma varchar(150),
isProibido varchar(150),
fkMaquina int,
primary key(idPrograma)
);

create table registroPrograma(
idRegistroPrograma int auto_increment,
consumoCPU varchar(150),
consumoMemoria varchar(150),
dataHora varchar(150),
fkPrograma int,
primary key (idRegistroPrograma)
);