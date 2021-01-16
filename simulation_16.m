%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation_16.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Percorre o mapa sempre em direção ao maior valor sempre retirando um ponto
% do valor para mudar o ambiente e permitindo passar 2 vezes na mesma posição.
% Valores da matriz inicialmente entre 0 e 80. Impede voltar à casa anterior.
% Calcula energy consumida, tempo de voo e número de guinadas.
% Realiza esse experimento num_exp vezes.
%
% Versão para vários cenários:
% Scenario # 1 - Sem vento, sem considerar vento
% não comente as linhas 133 e 279, comente a linha 280
% 
% Scenario # 2 - Vento constante int=1,5m/s e dir=20graus, sem considerar o vento
% comente a 133 e 280, não comente a 130 a 279
%
% Scenario # 3 - Vento constante int=1,5m/s e dir=20graus, considerando o vento constante
% comente a 133 e 279, não comente a 130 a 280
%
% Scenario # 4 - Vento variável com média int=1,5m/s e dir=20graus, considerando o vento constante
% comente a 130, 133 e 279, não comente a 280
%
% Scenario # 5 - Vento variável com média int=1,5m/s e dir=20graus, considerando o vento variável
%
%
%

clc; 

% Montando a matriz com o vento variável
v = [180 0.8 ; 180 0.8 ; 180 1.9 ; 180 1.3 ; 180 1.5 ; 	180 1.5 ; 180 1.5 ; 180 1.2 ; 180 1.2 ; 180 1.8 ; 
	175 1.2 ; 170 1.0 ; 170 1.0 ; 175 1.7 ; 170 1.1 ;	160 1.2 ; 150 1.2 ; 150 1.8 ; 155 1.0 ; 155 0.8 ;
	155 0.8 ; 155 0.8 ; 155 0.0 ; 155 0.0 ; 155 0.0 ;	155 0.0 ; 155 0.0 ; 160 0.0 ; 165 0.0 ; 165 0.0 ; 
	165 0.0 ; 165 0.0 ; 165 0.0 ; 165 0.0 ; 165 0.0 ;	165 0.0 ; 160 0.0 ; 150 0.9 ; 145 0.9 ; 145 1.8 ;
	145 1.8 ; 145 1.8 ; 135 3.8 ; 125 3.0 ; 120 3.0 ;	120 4.0 ; 120 4.0 ; 120 3.7 ; 125 3.7 ; 135 3.2 ;
	135 3.2 ; 135 3.2 ; 135 3.2 ; 135 3.2 ; 135 3.4 ;	135 3.4 ; 135 3.4 ; 135 3.5 ; 130 3.5 ; 130 3.2 ;
	130 3.2 ; 130 3.2 ; 130 3.0 ; 130 3.0 ; 130 3.0 ;	130 3.1 ; 130 3.8 ; 135 3.6 ; 135 3.6 ; 130 3.8 ;
	135 3.9 ; 135 3.9 ; 135 3.8 ; 130 3.8 ; 130 3.9 ;	135 3.3 ; 135 3.3 ; 135 2.9 ; 135 2.9 ; 135 2.8 ;
	135 2.8 ; 135 2.8 ; 135 2.8 ; 135 2.8 ; 130 2.8 ;	130 2.5 ; 120 2.8 ; 100 2.8 ; 080 2.0 ; 080 2.8 ;
	080 1.5 ; 080 1.5 ; 085 1.2 ; 080 1.2 ; 085 1.2 ;	095 1.3 ; 085 1.3 ; 080 1.4 ; 085 1.4 ; 080 1.6 ;
	090 1.6 ; 095 1.6 ; 100 2.8 ; 105 2.0 ; 105 2.3 ; 	095 2.3 ; 095 2.3 ; 120 2.3 ; 135 2.3 ; 140 2.3 ;
    140 2.5 ; 140 2.5 ; 140 2.5 ; 140 3.2 ; 135 3.2 ; 	110 3.6 ; 105 3.6 ; 105 3.6 ; 105 3.6 ; 110 3.6 ;
    120 3.5 ; 120 3.9 ; 120 3.3 ; 105 3.3 ; 105 3.4 ; 	090 3.4 ; 090 3.8 ; 100 3.8 ; 105 3.6 ; 110 3.8 ;
    120 3.8 ; 130 3.1 ; 130 2.8 ; 130 2.6 ; 120 2.6 ; 	120 2.6 ; 120 2.6 ; 120 3.1 ; 120 3.1 ; 120 3.4 ;
	130 3.4 ; 135 3.2 ; 135 3.8 ; 135 3.2 ; 135 3.2 ;	135 3.2 ; 135 3.2 ; 135 3.0 ; 135 3.0 ; 135 3.0 ; 
	135 3.1 ; 135 3.1 ; 135 3.3 ; 130 3.3 ; 130 3.2 ;	135 3.2 ; 135 3.0 ; 135 3.0 ; 135 3.0 ; 135 2.8 ;
	135 2.8 ; 135 2.8 ; 135 2.6 ; 135 2.6 ; 135 2.9 ;	135 2.3 ; 135 2.3 ; 135 2.3 ; 135 2.3 ; 135 2.9 ;
	135 2.5 ; 135 2.9 ; 140 2.3 ; 140 2.9 ; 140 2.5 ;	140 2.5 ; 140 2.5 ; 140 2.6 ; 140 2.6 ; 140 2.2 ; 
    140 2.2 ; 140 2.2 ; 140 1.9 ; 135 1.9 ; 135 1.9 ;	135 1.7 ; 135 1.7 ; 130 1.7 ; 125 1.7 ; 120 1.7 ; 
	120 1.7 ; 120 1.7 ; 120 1.8 ; 120 1.8 ; 120 1.8 ;	120 1.9 ; 125 1.9 ; 130 1.9 ; 130 1.9 ; 130 1.8 ;
	125 1.8 ; 120 1.8 ; 120 1.8 ; 120 1.8 ; 120 1.9 ;	120 1.9 ; 120 1.9 ; 120 2.0 ; 120 2.0 ; 115 2.8 ;
	115 2.2 ; 110 2.8 ; 110 2.5 ; 115 2.5 ; 120 2.5 ;	125 2.5 ; 130 2.5 ; 135 2.5 ; 130 2.5 ; 130 3.3 ; 
	130 3.3 ; 130 3.3 ; 135 4.1 ; 135 4.1 ; 135 4.2 ;	135 4.2 ; 130 4.2 ; 125 4.8 ; 110 4.6 ; 130 4.6 ; 
	110 5.0 ; 115 5.0 ; 135 4.7 ; 135 4.7 ; 135 4.4 ;	135 4.4 ; 135 4.5 ; 135 4.9 ; 135 4.5 ; 135 4.5 ;
	135 4.5 ; 140 4.5 ; 135 4.1 ; 130 4.1 ; 115 3.1 ;	105 3.1 ; 090 3.1 ; 085 2.2 ; 095 2.2 ; 085 2.2 ;
	105 1.9 ; 085 1.9 ; 085 2.0 ; 085 2.0 ; 085 1.8 ;	090 1.8 ; 085 1.6 ; 090 1.6 ; 090 1.6 ; 090 1.7 ; 
	090 1.7 ; 090 1.7 ; 090 1.7 ; 100 1.7 ; 105 1.7 ;	115 1.5 ; 120 1.5 ; 120 1.8 ; 120 1.8 ; 120 1.8 ; 
	115 2.1 ; 115 2.1 ; 110 2.1 ; 110 2.1 ; 115 2.1 ;	115 2.2 ; 120 2.2 ; 120 2.8 ; 120 2.8 ; 115 2.8 ;
	115 3.4 ; 115 3.4 ; 110 4.1 ; 110 4.1 ; 110 4.6 ;	110 4.6 ; 115 4.6 ; 120 4.3 ; 120 4.3 ; 125 3.3 ; 
	120 3.7 ; 120 3.7 ; 120 3.2 ; 120 3.2 ; 120 3.1 ;	130 3.1 ; 135 3.1 ; 135 2.9 ; 135 2.9 ; 135 2.8 ;
	135 3.2 ; 130 3.2 ; 125 3.3 ; 115 3.3 ; 105 3.3 ;	105 2.7 ; 095 2.7 ; 090 2.1 ; 110 2.1 ; 105 2.0 ; 
	105 2.0 ; 120 2.1 ; 130 2.1 ; 135 2.1 ; 125 2.1 ;	120 2.1 ; 105 2.1 ; 100 2.1 ; 095 2.1 ; 090 2.1 ; 
	085 1.8 ; 090 1.8 ; 090 1.5 ; 090 1.5 ; 100 1.5 ;	115 1.4 ; 120 1.4 ; 135 1.5 ; 135 1.5 ; 135 1.5 ;
	135 1.5 ; 135 1.5 ; 135 1.4 ; 135 1.4 ; 135 1.4 ;	135 1.4 ; 135 1.4 ; 135 1.4 ; 125 1.4 ; 120 1.3 ;
	120 1.3 ; 105 1.2 ; 090 1.2 ; 095 1.2 ; 090 1.2 ;   080 1.3 ; 090 1.3 ; 085 1.9 ; 085 1.9 ; 085 2.3 ; 
	095 2.3 ; 085 2.3 ; 080 2.3 ; 085 2.3 ; 090 2.3 ;	090 1.9 ; 090 1.9 ; 090 1.4 ; 105 1.4 ; 105 1.4 ;
	120 0.9 ; 130 0.9 ; 135 0.0 ; 135 0.8 ; 135 0.9 ;	135 0.8 ; 135 0.9 ; 135 1.2 ; 135 1.2 ; 135 1.1 ;
	135 1.1 ; 135 0.8 ; 135 0.8 ; 135 0.8 ; 135 0.8 ;	135 0.0 ; 135 0.0 ; 135 0.0 ; 130 0.0 ; 130 0.0 ;
	130 0.0 ; 125 0.0 ; 120 0.0 ; 115 0.0 ; 110 0.0 ;	105 0.0 ; 105 0.0 ; 105 0.0 ; 100 0.0 ; 100 0.0 ; 
	100 0.0 ; 095 0.0 ; 095 0.8 ; 100 0.8 ; 105 0.8 ;	105 1.1 ; 105 1.2 ; 105 1.2 ; 090 1.2 ; 080 1.3 ;
	095 1.4 ; 095 1.4 ; 085 1.8 ; 080 1.8 ; 090 1.8 ;	090 2.0 ; 090 2.0 ; 090 1.9 ; 090 1.9 ; 090 2.0 ;
	085 2.0 ; 080 2.0 ; 085 2.2 ; 085 2.2 ; 080 2.2 ;	095 2.0 ; 095 2.0 ; 085 1.6 ; 095 1.6 ; 085 1.6 ; 
	095 1.8 ; 085 1.8 ; 100 2.1 ; 105 2.1 ; 105 2.3 ;	105 2.3 ; 105 2.3 ; 105 2.5 ; 105 2.5 ; 110 2.5 ;
	110 2.7 ; 110 2.9 ; 110 2.5 ; 115 2.5 ; 115 2.5 ;	115 2.3 ; 110 2.3 ; 110 2.3 ; 110 2.3 ; 105 2.3 ;
	110 2.2 ; 115 2.8 ; 120 2.0 ; 120 2.0 ; 120 2.0 ;	120 2.0 ; 120 2.0 ; 120 2.0 ; 120 2.0 ; 120 1.7 ;
	120 1.7 ; 120 1.7 ; 120 1.4 ; 120 1.4 ; 120 1.2 ;	120 1.2 ; 120 1.2 ; 120 0.8 ; 120 0.8 ; 120 0.8 ;
	120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ;	120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ;
	120 0.0 ; 120 0.0 ; 125 0.0 ; 125 0.0 ; 120 0.0 ;	125 0.0 ; 125 0.0 ; 125 0.0 ; 125 0.0 ; 125 0.0 ;
	125 0.0 ; 125 0.0 ; 125 0.0 ; 125 0.0 ; 125 0.0 ;	120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ;
	120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ;	120 0.0 ; 120 0.0 ; 115 0.0 ; 110 0.0 ; 110 0.0 ;
	105 0.0 ; 105 0.0 ; 105 0.0 ; 100 0.0 ; 095 0.0 ;	090 0.0 ; 090 0.0 ; 090 0.0 ; 090 0.0 ; 090 0.0 ;
	090 0.0 ; 090 0.0 ; 090 0.1 ; 090 0.1 ; 090 0.8 ;	090 0.8 ; 090 0.0 ; 090 0.0 ; 090 0.0 ; 090 0.0 ;
	090 0.0 ; 090 0.0 ; 090 0.0 ; 100 0.0 ; 105 0.0 ;	105 0.7 ; 110 0.7 ; 115 1.1 ; 115 1.1 ; 120 1.3 ;
	120 1.3 ; 110 1.3 ; 105 1.2 ; 105 1.2 ; 100 1.8 ;	100 1.8 ; 105 1.0 ; 110 1.0 ; 120 1.1 ; 130 1.4 ;
	130 1.6 ; 130 2.2 ; 130 2.2 ; 130 2.2 ; 130 2.2 ;	130 2.7 ; 130 2.7 ; 130 2.7 ; 130 2.7 ; 130 2.7 ;
	130 2.5 ; 130 2.5 ; 130 2.4 ; 130 2.4 ; 130 2.4 ;	120 2.5 ; 120 2.5 ; 120 2.2 ; 130 2.2 ; 130 2.2 ; 
	130 1.9 ; 130 1.9 ; 125 2.0 ; 125 2.0 ; 125 2.8 ;	130 2.8 ; 130 2.8 ; 130 3.3 ; 130 3.3 ; 130 2.9 ; 
	130 2.9 ; 130 2.9 ; 130 2.8 ; 130 2.8 ; 130 2.8 ;	130 3.0 ; 130 3.0 ; 125 2.8 ; 120 2.9 ; 110 2.9 ; 
	105 2.4 ; 100 2.4 ; 100 2.1 ; 090 2.1 ; 085 1.8 ;	080 1.8 ; 095 1.7 ; 090 1.7 ; 095 1.7 ; 095 1.9 ; 
	085 1.9 ; 090 1.9 ; 105 2.0 ; 105 2.0 ; 110 2.3 ;	110 2.3 ; 110 2.3 ; 110 2.5 ; 110 2.5 ; 115 2.5 ;
	115 2.5 ; 120 2.5 ; 120 2.3 ; 120 2.3 ; 120 2.3 ;	120 2.1 ; 120 1.9 ; 120 1.9 ; 120 1.9 ; 120 1.6 ;
	120 1.8 ; 120 1.6 ; 120 1.3 ; 120 1.3 ; 120 1.0 ;	120 1.0 ; 120 1.0 ; 120 0.1 ; 120 0.1 ; 120 0.0 ;
	115 0.0 ; 110 0.0 ; 105 0.0 ; 105 0.0 ; 080 0.8 ;	080 0.8 ; 095 0.8 ; 090 1.3 ; 105 1.3 ; 090 1.3 ; 
	080 1.8 ; 090 1.8 ; 090 2.4 ; 110 2.4 ; 100 2.4 ;	080 2.6 ; 095 2.6 ; 105 2.1 ; 120 2.1 ; 125 2.1 ;
	125 1.7 ; 125 1.7 ; 120 1.7 ; 120 1.7 ; 115 1.7 ;	110 1.9 ; 120 1.9 ; 120 1.7 ; 120 1.7 ; 120 1.7 ; 
	115 1.7 ; 115 1.7 ; 115 1.7 ; 115 1.7 ; 115 1.7 ;	110 1.7 ; 110 2.0 ; 110 2.0 ; 105 2.0 ; 105 2.4 ; 
	105 2.4 ; 105 2.4 ; 110 2.4 ; 120 2.4 ; 120 2.4 ;	120 2.1 ; 120 2.0 ; 120 2.0 ; 120 2.0 ; 120 1.7 ; 
	120 1.7 ; 120 1.7 ; 120 1.4 ; 120 1.4 ; 120 1.2 ;	120 1.2 ; 120 1.1 ; 120 1.1 ; 120 1.1 ; 120 1.2 ;
	120 1.2 ; 120 1.4 ; 120 1.4 ; 120 1.4 ; 120 1.6 ;	120 1.6 ; 120 1.6 ; 120 1.8 ; 120 1.8 ; 120 1.8 ;
	120 1.8 ; 120 1.8 ; 120 1.5 ; 120 1.5 ; 120 1.2 ;	120 1.2 ; 120 1.2 ; 120 1.1 ; 120 1.1 ; 120 1.1 ;
	120 1.1 ; 120 1.1 ; 120 1.1 ; 120 1.1 ; 110 1.1 ;	100 1.1 ; 095 1.5 ; 090 1.5 ; 085 1.5 ; 080 1.5 ; 
	095 1.7 ; 080 1.7 ; 085 1.5 ; 080 1.5 ; 080 1.4 ;	080 1.4 ; 080 1.4 ; 080 1.2 ; 085 1.2 ; 090 1.2 ;
	080 0.8 ; 085 0.8 ; 085 0.0 ; 085 0.0 ; 095 0.0 ;	080 0.0 ; 080 0.0 ; 085 0.0 ; 090 0.0 ; 105 0.0 ;
	105 0.0 ; 115 0.0 ; 120 0.0 ; 115 0.0 ; 105 0.0 ;	105 0.0 ; 105 0.8 ; 105 0.8 ; 110 0.8 ; 115 1.4 ;
	115 1.4 ; 120 1.9 ; 120 1.9 ; 120 1.9 ; 120 2.0 ;	120 2.0 ; 120 1.8 ; 120 1.9 ; 120 1.9 ; 120 1.9 ; 
	120 1.9 ; 120 1.9 ; 120 1.8 ; 115 1.8 ; 115 1.8 ;	105 1.6 ; 105 1.6 ; 090 1.6 ; 095 1.6 ; 095 1.6 ;
	080 1.6 ; 085 1.6 ; 090 1.8 ; 090 1.4 ; 080 1.4 ;	080 1.4 ; 095 1.4 ; 080 1.5 ; 085 1.5 ; 080 1.5 ; 
	085 1.5 ; 095 1.9 ; 090 1.7 ; 085 1.7 ; 080 1.7 ;	085 1.8 ; 085 1.8 ; 095 1.8 ; 085 1.8 ; 085 1.6 ;
	085 1.6 ; 080 1.6 ; 090 1.4 ; 080 1.4 ; 090 1.4 ;	085 1.3 ; 080 0.9 ; 085 0.9 ; 100 0.9 ; 105 0.9 ; 
	120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ; 120 0.0 ;	120 0.1 ; 120 0.1 ; 120 1.0 ; 120 1.0 ; 120 1.0 ;
	120 1.3 ; 120 1.9 ; 120 1.4 ; 120 1.4 ; 120 1.4 ;	120 1.4 ; 120 1.5 ; 120 1.5 ; 120 1.5 ; 120 1.5 ;
	120 1.5 ; 120 1.6 ; 120 1.6 ; 115 1.6 ; 115 1.7 ;	115 1.7 ; 115 1.9 ; 115 1.9 ; 115 1.9 ; 115 2.1 ;
	110 2.1 ; 110 2.1 ; 105 2.3 ; 105 2.3 ; 100 2.4 ;	100 2.4 ; 105 2.4 ; 105 2.2 ; 110 2.2 ; 115 2.2 ;
	115 2.0 ; 115 2.2 ; 115 2.6 ; 120 2.6 ; 120 2.6 ;	115 3.1 ; 115 3.1 ; 115 2.8 ; 115 2.8 ; 115 2.8 ;
	110 2.6 ; 110 2.6 ; 110 2.9 ; 115 2.9 ; 115 2.9 ;	115 3.3 ; 115 3.3 ; 115 3.8 ; 115 3.0 ; 115 3.0 ;
	115 2.5 ; 115 2.5 ; 115 2.8 ; 120 2.0 ; 120 2.0 ;	120 1.8 ; 120 1.8 ; 115 1.8 ; 110 1.8 ; 110 1.8 ;
	110 1.8 ; 105 1.8 ; 105 1.8 ; 105 1.8 ; 105 1.8 ;	105 1.6 ; 105 1.6 ; 105 1.3 ; 105 1.3 ; 105 1.3 ; 
	105 1.1 ; 110 1.1 ; 115 1.0 ; 115 1.0 ; 115 1.0 ;	115 1.1 ; 115 1.2 ; 115 1.2 ; 115 1.2 ; 115 1.2 ;
	110 1.1 ; 110 1.1 ; 105 1.1 ; 105 1.1 ; 110 1.1 ;	105 1.1 ; 105 1.1 ; 105 1.1 ; 105 1.1 ; 105 1.1 ; 
	105 1.1 ; 105 1.1 ; 105 1.3 ; 105 1.3 ; 105 1.5 ;	110 1.5 ; 115 1.5 ; 115 1.7 ; 115 1.7 ; 115 1.7 ];

% Ajustando a escala para ter a velocidade média do vento de 1,5 m/s e direção média do vento de 20 graus
v = [ v(:,1)-95.4412  v(:,2)*0.8197 ];

% Montando vetor com 20.000 medidas de vento
v = [ v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v ; v];

% Montando a matriz com o vento constante veloc 1,5 m/s e dirc 20 grau
% v = [ 20*ones(20000,1)  1.5*ones(20000,1) ];

% Tornando o vento zero 
% v = 0*v;


% Curvas de solução dos triângulos para veloc do vento de [0.0 0.5 1.0 1.5 2.0]
% ângulo Beta de [000 010 020 ... 170 180] e veloc no chão de [1 2 3 4]

vg_00 = [   1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	;
            1	2	3	4	];

vg_05 = [   1.5     2.5     3.5     4.5     ;
            1.49	2.49	3.49	4.49	;
            1.46	2.46	3.47	4.47	;
            1.4     2.42	3.42	4.43	;
            1.33	2.36	3.37	4.37	;
            1.25	2.28	3.3     4.3     ;
            1.15	2.2     3.22	4.23	;
            1.05	2.12	3.13	4.14	;
            0.96	2.03	3.05	4.06	;
            0.87	1.94	2.96	3.97	;
            0.78	1.85	2.87	3.88	;
            0.75	1.77	2.79	3.8     ;
            0.7     1.7     2.72	3.73	;
            0.65	1.64	2.65	3.66	;
            0.6     1.59	2.6     3.60	;
            0.55	1.55	2.56	3.56	;
            0.55	1.52	2.53	3.53	;
            0.5     1.51	2.51	3.51	;
            0.5     1.5     2.5     3.5	];


vg_10 = [   2       3       4       5	;
            1.97	2.98	3.98	4.98	;
            1.88	2.91	3.92	4.93	;
            1.73	2.8     3.82	4.84	;
            1.53	2.66	3.70	4.71	;
            1.29	2.49	3.54	4.57	;
            1       2.3     3.37	4.41	;
            0.5     2.11	3.19	4.23	;
            0.5     1.91	3.01	4.05	;
            0.5     1.73	2.83	3.87	;
            0.5     1.57	2.66	3.70	;
            0.5     1.42	2.51	3.55	;
            0.5     1.3     2.37	3.41	;
            0.5     1.21	2.26	3.28	;
            0.5     1.13	2.16	3.18	;
            0.5     1.07	2.09	3.10	;
            0.5     1.03	2.04	3.05	;
            0.5     1.01	2.01	3.01	;
            0.5     1       2       3	];

vg_15 = [   2.5     3.5     4.5     5.5	;
            2.44	3.46	4.47	5.47	;
            2.27	3.34	4.37	5.38	;
            1.96	3.15	4.2     5.23	;
            1.8     2.90	3.99	5.03	;
            1.6     2.6     3.74	4.8	;
            1.4     2.27	3.45	4.53	;
            1.2     1.93	3.16	4.26	;
            1       1.61	2.87	3.98	;
            0.9     1.32	2.6     3.71	;
            0.8     1.09	2.35	3.46	;
            0.7     0.91	2.14	3.23	;
            0.6     0.77	1.95	3.03	;
            0.5     0.67	1.81	2.87	;
            0.4     0.60	1.69	2.73	;
            0.3     0.56	1.61	2.63	;
            0.2     0.52	1.55	2.56	;
            0.1     0.51	1.51	2.51	;
            0       0.5     1.5     2.5	] ;

vg_20 = [   3       4       5       6	;
            2.91	3.94	4.95	5.96	;
            2.9     3.76	4.8     5.82	;
            2.4     3.46	4.56	5.61	;
            1.9     3.06	4.24	5.32	;
            1.5     2.57	3.87	4.98	;
            1.2     2       3.45	4.61	;
            1.0     1.37	3.02	4.22	;
            0.9     0.69	2.61	3.83	;
            0.8     0.3     2.24	3.46	;
            0.7     0       1.92	3.13	;
            0.6     0       1.65	2.85	;
            0.5     0       1.45	2.61	;
            0.4     0       1.29	2.41	;
            0.3     0       1.18	2.26	;
            0.2     0       1.1     2.14	;
            0.1     0       1.04	2.06	;
            0       0       1.01	2.02	;
            0       0       1       2	] ;

vg_matrix(1,:,:) = vg_00;   vg_matrix(2,:,:) = vg_05;   vg_matrix(3,:,:) = vg_10;
vg_matrix(4,:,:) = vg_15;   vg_matrix(5,:,:) = vg_20;

%%%%%%%%%%%%%%%%%%%%%%
% Início da simulação
%%%%%%%%%%%%%%%%%%%%%%

n = 100;                                    % grid with decision cells
p = 20000;                                   % number of visited decision cells

% Loop dos experimentos

num_exp = 100;                   % number of times the experiment is performed
stat_data = [];

for j=1:num_exp
    
    sel_imp_1 = round(num_exp*rand);
    sel_imp_2 = round(p*rand);
        
    a=clock;seed=rand('state')*a(6);seed=seed/(a(6)+1);
    rand('state', seed);
    
    area = round(100*rand(n,n));                % values of decision cells from 0 to 80
    caminho = [];                               % stores ecah cell of the path
    pos_0 = [ 1 1 ];    pos_1 = [ 2 1 ];        % define the firts movement
    caminho = [caminho pos_0'];                 % stores the first decision cell

    for k=1:p                               % flights over 20 thousand decision cells
        cand = [];
        teste1 = [ pos_1(1)-1 pos_1(2) ];   % south
        teste2 = [ pos_1(1) pos_1(2)+1 ];   % east
        teste3 = [ pos_1(1)+1 pos_1(2) ];   % north
        teste4 = [ pos_1(1) pos_1(2)-1 ];   % west
        
% Four different weight masks applied to the decision: [south east north west]
% a) [ 1.0 1.0 1.0 1.0 ]; b) [ 1.1 0.9 0.8 1.0 ]; c) [ 1.2 0.8 0.6 1.0 ]; d) [ 1.6 0.8 0.4 1.2 ]

% Using weights for: south(1.2), west(1.0), east(0.8), north(0.6)
%        pesos = [1.0 1.0 1.0 1.0];
        pesos = [ 1.6 0.8 0.4 1.2 ];
        
        [a , b]=size(caminho);
        
        if (teste1(1)>0) && (teste1(1)<(n+1)) && (teste1(2)>0) && (teste1(2)<(n+1))     % testando célula south
            aut=1;
            if (teste1(1)==caminho(1,b)) && (teste1(2)==caminho(2,b))
                aut=0;
            end
            if aut==1
                cand = [cand [teste1(1) ;  teste1(2) ; pesos(1)*area(teste1(1),teste1(2)) ] ];
            end
        end

        if (teste2(1)>0) && (teste2(1)<(n+1)) && (teste2(2)>0) && (teste2(2)<(n+1))     % testando célula east
            aut=1;
            if (teste2(1)==caminho(1,b)) && (teste2(2)==caminho(2,b))
                aut=0;
            end
            if aut==1
                cand = [cand [teste2(1) ;  teste2(2) ; pesos(2)*area(teste2(1),teste2(2)) ] ];
            end
        end

        if (teste3(1)>0) && (teste3(1)<(n+1)) && (teste3(2)>0) && (teste3(2)<(n+1))     % testando célula north
            aut=1;
            if (teste3(1)==caminho(1,b)) && (teste3(2)==caminho(2,b))
                aut=0;
            end
            if aut==1
                cand = [cand [teste3(1) ;  teste3(2) ; pesos(3)*area(teste3(1),teste3(2)) ] ];
            end
        end

        if (teste4(1)>0) && (teste4(1)<(n+1)) && (teste4(2)>0) && (teste4(2)<(n+1))     % testando célula west
            aut=1;
            if (teste4(1)==caminho(1,b)) && (teste4(2)==caminho(2,b))
                aut=0;
            end
            if aut==1
                cand = [cand [teste4(1) ;  teste4(2) ; pesos(4)*area(teste4(1),teste4(2)) ] ];
            end
        end

        maior = max(cand(3,:));
        [c , d] = size(cand);
        kk = 1;
        j=0;
        while (kk < d+1) && (j==0)
            if cand(3,kk) == maior
                area(pos_0(1),pos_0(2)) = area(pos_0(1),pos_0(2))-1;
                pos_0 = pos_1;
                pos_1 = (cand(1:2,kk))';
                j=1;
            end
            kk = kk+1;
        end
        caminho = [caminho pos_0'];
        
        if (k==p)
            %figure(1); subplot(221);
            %x = 10*ceil(max(caminho(2,:))/10);      y = 10*ceil(max(caminho(1,:))/10);
            %plot(caminho(1,:),caminho(2,:));axis([0 x 0 y]); axis square ;grid
        end
                       
    end
    % Energy consumption calculus
 
    Energy = 0;                % Initial energy consumption
 
    % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
 
        num_guin = 0;
        tempo = 0;
    
        % Para o primeiro trecho
        vw = v(1,2);    dir = v(1,1);
        if vw > 2
            vw = 2;
        end
        vw = (round(2*vw))/2;   dir = (round(dir/10))*10;
                
        % Verifica se haverá guinada ou não
        vec_1=caminho(:,2)-caminho(:,1);
        vec_2=caminho(:,3)-caminho(:,2);
        guinada = vec_1'*vec_2;         % guinada=0 ==> guina

        % Cálculo da Energia
                
        if guinada == 0;        % Haverá guinada
            situ = 1;            % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
            num_guin = num_guin + 1;
            rumo = (2*vec_1(1)+vec_1(2));       % 2:north 1:east -2:south -1:west
            beta2 = angulo(dir,rumo);
            vg1 = vg_matrix(vw/0.5+1,beta2/10+1,1); vg2 = vg_matrix(vw/0.5+1,beta2/10+1,2); vg3 = vg_matrix(vw/0.5+1,beta2/10+1,3);
            vgm = (2*vg1+4*vg2+4*vg3)/10;
            dt = 10/vgm;        dE = 214.7*dt+2*0.5*1.3*vgm^2;
            tempo = tempo + dt;
            Energy = Energy + dE;
        else
            situ = 2;            % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
            rumo = (2*vec_1(1)+vec_1(2));       % 2:north 1:east -2:south -1:west
            beta2 = angulo(dir,rumo);
            vg1 = vg_matrix(vw/0.5+1,beta2/10+1,1);
            vg2 = vg_matrix(vw/0.5+1,beta2/10+1,2);
            vg3 = vg_matrix(vw/0.5+1,beta2/10+1,3);
            vg4 = vg_matrix(vw/0.5+1,beta2/10+1,4);
            vgm = (1*vg1+2*vg2+3*vg3+4*vg4)/10;
            dt = 10/vgm;
            dE = 214.7*dt+0.5*1.3*vgm^2;
            tempo = tempo + dt;
            Energy = Energy + dE;
         end


    for i=3:p
        vec_1 = caminho(:,i)-caminho(:,i-1);    % vec_1=caminho(:,2)-caminho(:,1)
        vec_2 = caminho(:,i+1)-caminho(:,i);    % vec_2=caminho(:,3)-caminho(:,2)
        guinada = vec_1'*vec_2;                 % guinada = 0 --> vai guinar
 
        if (guinada == 0)
            if (situ == 1 || situ == 4)          % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
                situ = 1;
                num_guin = num_guin + 1;
                rumo = (2*vec_1(1)+vec_1(2));
                beta2 = angulo(dir,rumo);
                vg1 = vg_matrix(vw/0.5+1,beta2/10+1,1);
                vg2 = vg_matrix(vw/0.5+1,beta2/10+1,2);
                vg3 = vg_matrix(vw/0.5+1,beta2/10+1,3);
                vgm = (2*vg1+4*vg2+4*vg3)/10;
                dt = 10/vgm;
                dE = 214.7*dt+2*0.5*1.3*vgm^2;
                tempo = tempo + dt;
                Energy = Energy + dE;
                
            elseif (situ == 2 || situ == 3)        % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
                situ = 4;
                num_guin = num_guin + 1;
                rumo = (2*vec_1(1)+vec_1(2));
                beta2 = angulo(dir,rumo);
                vg1 = vg_matrix(vw/0.5+1,beta2/10+1,1);
                vg2 = vg_matrix(vw/0.5+1,beta2/10+1,2);
                vg3 = vg_matrix(vw/0.5+1,beta2/10+1,3);
                vg4 = vg_matrix(vw/0.5+1,beta2/10+1,4);
                vgm = (4*vg1+3*vg2+2*vg3+1*vg4)/10;
                dt = 10/vgm;
                dE = 214.7*dt+0.5*1.3*vgm^2;
                tempo = tempo + dt;
                Energy = Energy + dE;
            end
        else
            if (situ == 1 || situ == 4)             % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)       
                situ = 2;
                rumo = (2*vec_1(1)+vec_1(2));
                beta2 = angulo(dir,rumo);
                vg1 = vg_matrix(vw/0.5+1,beta2/10+1,1);
                vg2 = vg_matrix(vw/0.5+1,beta2/10+1,2);
                vg3 = vg_matrix(vw/0.5+1,beta2/10+1,3);
                vg4 = vg_matrix(vw/0.5+1,beta2/10+1,4);
                vgm = (1*vg1+2*vg2+3*vg3+4*vg4)/10;
                dt = 10/vgm;
                dE = 214.7*dt+0.5*1.3*vgm^2;
                tempo = tempo + dt;
                Energy = Energy + dE;
            elseif (situ == 2 || situ == 3)         % situ = 1(accel e decel)  2(accel)   3(max vel)   4(decel)
                situ = 3;
                rumo = (2*vec_1(1)+vec_1(2));
                beta2 = angulo(dir,rumo);
                vg4 = vg_matrix(vw/0.5+1,beta2/10+1,4);
                vgm = vg4;
                dt = 10/vgm;
                dE = 214.7*dt+0.5*1.3*vgm^2;
                tempo = tempo + dt;
                Energy = Energy + dE;
            end
        end
    end
 
    stat_data = [stat_data [ num_guin ; tempo ; Energy ] ];



end

figure(2); subplot(311);plot(stat_data(1,:));grid; title('Number of Turns');
subplot(312);plot(stat_data(2,:));grid; title('Flight Time');
subplot(313);plot(stat_data(3,:));grid; title('Consumed Energy');
xlabel('Simulation Number');

%figure(3); subplot(121); plot(stat_data(1,:),stat_data(2,:),'b.');grid;xlabel('Number of Turns'); ylabel('Flight Time');
%subplot(122); plot(stat_data(1,:),stat_data(3,:),'b.');grid;xlabel('Number of Turns'); ylabel('Consumed Energy');

%figure(4); plot(stat_data(2,:),stat_data(3,:),'b.');grid; xlabel('Flight Time'); ylabel('Consumed Energy');

%figure(5);
%subplot(221); scatter(stat_data(1,:),stat_data(2,:),'b.');grid; lsline; xlabel('Number of Turns'); ylabel('Flight Time');
%subplot(222); scatter(stat_data(1,:),stat_data(3,:),'b.');grid; lsline; xlabel('Number of Turns'); ylabel('Consumed Energy');
%subplot(223); scatter(stat_data(2,:),stat_data(3,:),'b.');grid; lsline; xlabel('Flight Time'); ylabel('Consumed Energy');

mean_turn = mean(stat_data(1,:))
mean_time = mean(stat_data(2,:))
mean_energy = mean(stat_data(3,:))

coef_turn_time = corrcoef(stat_data(1,:),stat_data(2,:))
coef_turn_energy = corrcoef(stat_data(1,:),stat_data(3,:))
coef_time_energy = corrcoef(stat_data(2,:),stat_data(3,:))








