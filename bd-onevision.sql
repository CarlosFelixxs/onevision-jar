create table maquina(
idMaquina int auto_increment, 
hostName varchar(50)
);

select * from componente;
create table componente(
idComponente int auto_increment,
nomeComponente varchar(40),
primary key(idComponente)
);

create table componenteMaquina(
idComponenteMaquina int auto_increment,
totalComponente double,
unidadeMedida VARCHAR(5),
fkComponente INT,
fkMaquina int,
foreign key (fkComponente) references componente (idComponente),
foreign key (fkMaquina) references maquina (idMaquina),
primary key(idComponenteMaquina, fkMaquina, fkComponente)
);

create table programa(
idPrograma int auto_increment,
nomePrograma varchar(40),
isProibido TINYINT,
fkMaquina int,
foreign key (fkMaquina) references Maquina (idMaquina),
primary key(idPrograma, fkMaquina)
);

create table registroPrograma(
idRegistroPrograma int auto_increment,
consumoCPU double,
consumoMemoria double,
dataHora datetime,
fkPrograma int,
foreign key (fkPrograma) references programa (idPrograma),
primary key (idRegistroPrograma, fkPrograma)
);