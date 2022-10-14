#!/bin/bash
#Author: Thaylon Roberto Muniz da Silva
#Data:13/10/2022
#SENAI-DF
#Instrutor:Felipão

clear

agendar(){
:
}

esp(){
printf "\n\n"
}
line(){

echo "--------------------------------------------"

}
lineG(){

echo "---------------------------------------------------------------------------------------"

}
menu(){
echo "-------------------BackUp-------------------"
echo "Escolha dentre as opções e digite o codigo"
esp
echo "  1-Backup de diretórios"
echo "  2-Backup de arquivos  "
echo "  3-Backup de discos    "
echo "  4-Agendar Backup      "
echo "  5-Exit                "
esp
echo "--------------------MENU--------------------"

echo "Opção:"; read opt
}


verf(){ 
a=0
while [ ! $opt -eq 1 -a ! $opt -eq 2 -a ! $opt -eq 3 -a ! $opt -eq 4 ]   
do
	clear
	menu
	lineG
	echo "Não há correspondentes para ($opt), digite somente ( 1 | 2 | 3 ) apenas um de cada vez"
	echo "Digite a opção:"
	read opt
	
done
}


agendamentoMenu(){

echo "Agende um horario ou data especifico para execução dos backups" 
esp
echo "--------------------------Data/Horario-------------------------"
echo "Defina os parametros a seguir, deixe em branco para não definir"

esp

a=0
while [ $a -eq 0 ]
do
	echo "Definir dia? y/n"; read respD

	if [ $respD == "y" ];
	then
	line
	echo "Dia:"; read Dia
	echo "Mês:"; read Mes
	echo "Ano:"; read Ano
	line
	clear
	fi

	echo "Definir Horario? y/n"
	read respH

	if [ $respH == "y" ]; 
	then
	esp
	line
	echo "Segundos:"; read sec 
	echo "Minutos:"; read min
	echo "Horas:"; read hora
	line
	fi
	clear
	line
	echo "Setar os seguintes parametros"
	echo "Data: $Dia/$Mes/$Ano"
	echo "Hoario: $sec:$min:$hora"
	line
	echo "Deseja continuar e setar os parametros? y/n"; read setar

	if [ $setar == "n" ]; then
	exit
	fi


done
}
vDir(){
while [ ! -d  $dir ]
do
        clear
	echo "----------------------------Caminho_Incorreto----------------------------"
        echo "Diretório ($dir), caminho ou nome incorretos, confira e informe novamente"
        echo "Diretorio:"
        read dir
	clear
done
}

vDir2(){
while [ ! -d  $dir2 ]
do
        clear
	echo "----------------------------Caminho_Incorreto----------------------------"
        echo "Diretório ($dir2), caminho ou nome incorretos, confira e informe novamente"
        echo "Diretorio:"
        read dir2  
	clear
done
}

vArv(){
while [ ! -f  $dir2 ]
do
        clear
        echo "----------------------------Caminho_Incorreto----------------------------"
        echo "Diretório ($dir2), caminho ou nome incorretos, confira e informe novamente"
        echo "Diretorio:"
        read dir2  
        clear
done
}


m1(){
clear
lineG
echo "<1-Backup de diretórios>"
echo "Informe o caminho absoluto do diretorio que deseja realizar o backup"
read dir
vDir
echo "Informe o caminho absoluto de destino aonde o backup sera armazenado"
read dir2
vDir2 
lineG
echo "O diretório ($dir2) sera salvo no ($dir) deseja continuar? y/n"
read resp

while [ $resp == "n" ]
do
clear
lineG
echo "A operação sera cancelada, deseja continuar? y/n"
read resp1

	if [ $resp1 == "y" ]; 
	then
	exit
	else 
	resp=y
	fi
done
	#realizando os backups ; 
	lineG
	echo "deseja que o programa pergunte antes de sobrescrever um arquivo? y/n"; read resp1
	if [ $resp1 == "y" ];
	then
	cp -r -i -p $dir $dir2
	else
	cp -r $dir $dir2
	fi 
	clear
	lineG
	echo "O backup de ($dir) para ($dir2) foi bem sucessido!!"

}

m2(){

clear
lineG
echo "<2-Backup de Arquivos>"
echo "Informe o caminho absoluto do arquivo(s) que deseja realizar o backup"
lineG
echo "dica: Vc pode utilizar expressões regulares para selecionar mais de um arquivo com certos padrões"
read dir
vArv
clear
lineG
echo "Informe o caminho absoluto de destino aonde o backup do arquivo(s) sera armazenado"
echo "Apenas diretorios"
read dir2
vDir2
clear; line 
echo "Deseja renomear o arquivo? y/n"
read conf
nomeArv=a

if [ $conf == "y" ];
then
clear
line
  echo "Informe o nome do arquivo"
  read nomeArv
  clear
fi

if [ ! $nomeArv == "a" ];
then

echo "Os arquivo(s) ($dir2 || $nomeArv) serão salvo no ($dir) deseja continuar? y/n"
read resp

while [ $resp == "n" ]
do
clear; line
echo "A operação sera cancelada, deseja continuar? y/n"
read resp 

        if [ $resp == "n" ]; 
        then
        exit
        else 
        resp=y
        fi
done
        #realizando os backups ; 
        clear; lineG
	echo "deseja que o programa pergunte antes de sobrescrever um arquivo? y/n"; read resp1
        if [ $resp1 == "y" ];
        then
        cp -r -i -p $dir  $dir2/$nomeArv
        else
        cp -r $dir $dir2/$nomeArv
        fi 
        clear
	lineG
        echo "O backup de ($dir == $nomeArv) para ($dir2/$nomeArv) foi bem sucedido!!" 
fi




}
verfBk(){

while [ ! -d $inBackup  ] 
do	
	clear
	line
	echo "Diretorios não enontrados"
	echo "Verifique e informe novamente" 
	echo "Diretório:"
	read inBackup

done
}


verfB2k(){

while [ ! -d $outBackup ] 
do  
	clear; line
        echo "Diretorios não enontrados"
        echo "Verifique e informe novamente" 
        echo "Diretório:" 
        read outBackup

done
}

m3(){
clear
lineG
echo "<3-Backup de Discos>" 
echo "Informe o diretorio de Sistema para realizar o Backup"
read inBackup
verfBk
clear; lineG
echo "Informe o ditetorio de Sistema para onde deve ser armazenado o Backup"
read outBackup
verfB2k
clear; lingG
echo "Deseja realizar o backup compreensando os arquivos? y/n"
read resp

if [ $resp == "y" ];
then
	rsync -azv $inBackup $outBackup
else
	rsync -avf $inBackup $outBackup
fi

clear 
line
echo "Arquivos de Backup realizados com sucesso"
line
}


m4(){
clear
line 
echo "Obrigado por usar o programa, by TRMS"
line
}

menuPrincipal(){

	case $opt in 
	1)m1;;
	2)m2;;
	3)m3;;
	4)agendamentoMenu;;
	5)m5
	esac
}

menu
verf
menuPrincipal

