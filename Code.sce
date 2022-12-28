clear
clc

disp('Questão 1: Linha de Trasmissão')

zl=input('Digite a impedância da carga:');
zo=input('Digite a impedância da linha:');
tam=input('Digite o tamanho da linha em função do comprimento de onda:');
f=input('Digite a frequência de funcionamento da linha em Hz:');

disp('1 - Coeficiente de reflexão da carga.')
disp('2 - Coeficiente de onda estacionária.')
disp('3 - Impedância de entrada.')
disp('4 - Casamento por quarto de onda.')
disp('5 - Casamento por elemento reativo em série')
disp('6 - Casamento por elemento reativo em paralelo')
disp('7 - Casamento por toco simples em série')
disp('8 - Casamento por toco simples em paralelo')
disp('9 - Casamento por toco duplo')
disp('10 - Sair')

//cálculos gerais da linha
zm = sqrt(zo*zl);
talL=(zl-zo)/(zl+zo);
coe=(1+abs(talL))/(1-abs(talL));
zin = zo*(zl+(%i.*zo.*tan(2.*%pi.*tam)))/(zo+(%i.*zl.*tan(2.*%pi.*tam)));

//impedância de carga normalizada
zln = (zl/zo);
yln = 1/zln;

//cálculo para casamento 
talR = (abs(talL))^2;
talI = [-sqrt(-(talR)^2 + talR),sqrt(-(talR)^2 + talR)];

//ajustar toco simples e casamentos em paralelo
for i=1:2
for j=1:2
    if i<>j then
    x(i) = (2*talI(i))/((1-talR)^2 + (talI(i))^2);
    zd(i) = 1 + %i.*x(i);
    Zcasamento(i) = zo*(1-zd(i));
    
    Pelemento(j) = ((0.25/-%pi).*atan(talI(i),talR)) + 0.25;
    Pcarga = ((0.25/-%pi).*atan(imag(talL),real(talL))) + 0.25;
    Pcarga_Y = ((0.25/-%pi).*atan(imag(-talL),real(-talL))) + 0.25;

    talR_toco(i) = ((x(i)^2) - 1)/((x(i)^2) + 1);
    talI_toco(i) = (2*x(i))/((x(i)^2) + 1);
    Ptoco(j) = ((0.25/-%pi).*atan(talI_toco(i),talR_toco(i))) + 0.25;
    
    if (Pelemento(j) - Pcarga) < 0 then
    Delemento(j) = 0.5 - abs(Pelemento(j) - Pcarga);

    else
    Delemento(j) = Pelemento(j) - Pcarga;
end
    if (Pelemento(j) - Pcarga_Y) < 0 then
    Delemento_Y(j) = 0.5 - abs(Pelemento(j) - Pcarga_Y);
    else
    Delemento_Y(j) = Pelemento(j) - Pcarga_Y;
end

    if (Ptoco(j)-0.25) < 0 then
    DtocoCURTO(j) = 0.5 - abs(Ptoco(j)-0.25);
    else
    DtocoCURTO(j) = Ptoco(j)-0.25;
  end
    DtocoABERTO(j) = abs(Ptoco(j));

    DtocoABERTO_Y(i) = DtocoABERTO(j);
    DtocoCURTO_Y(i) = DtocoCURTO(j);
  end
end
end

//calculo da posição dos tocos (duplo)
r = real(yln);
aux = sqrt(-(r-2)*r*((r+1)^2));

    talR_a = (3*(r^2)-r-aux)/(5*(r^2)+(2*r)+1);
    talI_a = ((r^3)+(r^2)-(2*aux*r)+r+1)/((r+1)*((5*(r^2))+(2*r)+1));
    tal_a = talR_a + %i.*talI_a;
    Y_a = (1+tal_a)/(1-tal_a);
    
    Y_l1 = imag(Y_a - yln);
    talR_toco1 = ((Y_l1^2) - 1)/((Y_l1^2) + 1);
    talI_toco1 = (2*Y_l1)/((Y_l1^2) + 1);
    Ptoco1 = ((0.25/-%pi).*atan(talI_toco1,talR_toco1)) + 0.25;
    
    if (Ptoco1-0.25) < 0 then
    Dtoco1CURTO = 0.5 - abs(Ptoco1-0.25);
    else
    DtocoCURTO1 = Ptoco1-0.25;
    end
    
    Pcarga_a = ((0.25/-%pi).*atan(talI_a,talR_a)) + 0.25;
    
    talR_a2 = (abs(tal_a))^2;
    talI_a2 = sqrt(-(talR_a2)^2 + talR_a2);
    x_a2 = -(2*talI_a2)/((1-talR_a2)^2 + (talI_a2)^2);
    Pelemento_a2 = ((0.25/-%pi).*atan(talI_a2,talR_a2)) + 0.25;
    
    if (Pelemento_a2 - Pcarga_a) < 0 then
    Delemento_a = 0.5 - abs(Pelemento_a2 - Pcarga_a);
    else
    Delemento_a = Pelemento_a2 - Pcarga_a;
    end
    
    talR_a2_toco = ((x_a2^2) - 1)/((x_a2^2) + 1);
    talI_a2_toco = (2*x_a2)/((x_a2^2) + 1);
    Ptoco2 = ((0.25/-%pi).*atan(talI_a2_toco,talR_a2_toco)) + 0.25;
    
    if (Ptoco2-0.25) < 0 then
    Dtoco2CURTO = 0.5 - abs(Ptoco2-0.25);
    else
    DtocoCURTO2 = Ptoco2-0.25;
    end


k=0; while k==0

entrada=input('Digite o que deseja obter:');

 if entrada == 1 then
 entrada1=input('Digite 1 se quiser o valor na forma polar. Se quiser na forma retangular, digite qualquer outro número:');
 if entrada1 == 1 then
 disp('Módulo seguido pela fase em radianos:',abs(talL),atan(imag(talL),real(talL)))
 else
 disp(talL)
end
end

if entrada == 2 then
  disp(coe)
end

if entrada == 3 then
    disp(zin)
end

if entrada == 4 then
 disp('Impedância da linha adicionada:', zm)
 disp('Comprimento da linha adicionada:', (1/4)*tam)
end

if entrada == 5 then
    for i=1:2
    if imag(Zcasamento(i)) > 0 then
    disp('Precisaríamos de um capacitor de impedância:', (-Zcasamento(i)))
    disp('A uma distância da carga de (em comprimentos de onda):', (Delemento(i)))
    disp('Com uma capacitância, em Faradays, de:', (1/(2*f.*%pi.*abs(Zcasamento(i)))))
end
    if imag(Zcasamento(i)) < 0 then
    disp('Precisaríamos de um indutor de impedância:', (-Zcasamento(i)))
    disp('A uma distância da carga de (em comprimentos de onda):', (Delemento(i)))
    disp('Com uma indutância, em Henrys, de:', (abs(Zcasamento(i))/(2*f.*%pi)))
end
end
end

if entrada == 6 then
    for i=1:2
    if imag(Zcasamento(i)) > 0 then
    disp('Precisaríamos de um capacitor de impedância:', (-Zcasamento(i)))
    disp('A uma distância da carga de (em comprimentos de onda):', (Delemento_Y(i)))
    disp('Com uma capacitância, em Faradays, de:', (1/(2*f.*%pi.*abs(Zcasamento(i)))))
end
    if imag(Zcasamento(i)) < 0 then
    disp('Precisaríamos de um indutor de impedância:', (-Zcasamento(i)))
    disp('A uma distância da carga de (em comprimentos de onda):', (Delemento_Y(i)))
    disp('Com uma indutância, em Henrys, de:', (abs(Zcasamento(i))/(2*f.*%pi)))
end
end
end

if entrada == 7 then
 entrada2=input('Digite 1 se quiser o toco em curto-circuito. Se quer em aberto, digite qualquer outro número:');
 for i=1:2
 if entrada2 == 1 then
    disp('A impedância do toco pode ser:', (-Zcasamento(i)))
    disp('A uma distância, em comprimentos de onda, de:', (Delemento(i)))
    disp('O toco terá um tamanho, em comprimentos de onda, de:', (DtocoCURTO(i)))
 else
    disp('A impedância do toco pode ser:', (-Zcasamento(i)))
    disp('A uma distância, em comprimentos de onda, de:', (Delemento(i)))
    disp('O toco terá um tamanho, em comprimentos de onda, de:', (DtocoABERTO(i)))
end
end
end

if entrada == 8 then
 entrada2=input('Digite 1 se quiser o toco em curto-circuito. Se quer em aberto, digite qualquer outro número:');
 for i=1:2
 if entrada2 == 1 then
    disp('A impedância do toco pode ser:', (-Zcasamento(i)))
    disp('A uma distância, em comprimentos de onda, de:', (Delemento_Y(i)))
    disp('O toco terá um tamanho, em comprimentos de onda, de:', (DtocoCURTO_Y(i)))
 else
    disp('A impedância do toco pode ser:', (-Zcasamento(i)))
    disp('A uma distância, em comprimentos de onda, de:', (Delemento_Y(i)))
    disp('O toco terá um tamanho, em comprimentos de onda, de:', (DtocoABERTO_Y(i)))
end
end
end

if entrada == 9 then
 disp('A adimitância do primeiro toco pode ser:', Y_l1.*%i)
 disp('O primeiro toco terá um tamanho, em comprimentos de onda, de:', DtocoCURTO1)
 
  disp('A distância para o segundo toco é, em comprimentos de onda, de 0.125')
  
 disp('A adimitância do segundo toco pode ser:', x_a2.*%i)
 disp('O segundo toco terá um tamanho, em comprimentos de onda, de:', DtocoCURTO2)
end

if entrada == 10 then
    k=1
end

end

  
  
 
  
  
  
  
  
