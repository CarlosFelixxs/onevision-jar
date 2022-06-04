create table maquina(
idMaquina int not null auto_increment, 
hostName varchar(150),
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