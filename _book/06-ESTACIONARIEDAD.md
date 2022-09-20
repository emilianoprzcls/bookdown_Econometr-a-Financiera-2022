---
title: "06-ESTACIONARIEDAD"
author: "Emiliano Pérez Caullieres"
date: "2022-09-20"
output: pdf_document
---
# ESTACIONARIEDAD
### Dependencias

```r
#install.packages("pacman")
#pacman nos permite cargar varias librerias en una sola línea
library(pacman)
pacman::p_load(tidyverse,BatchGetSymbols,ggplot2,lubridate,readxl,forecast,stats)
```



```r
#Primero determinamos el lapso de tiempo
pd<-Sys.Date()-(365*20) #primer fecha
pd
#> [1] "2002-09-25"
ld<-Sys.Date() #última fecha
ld
#> [1] "2022-09-20"
#Intervalos de tiempo
int<-"monthly"
#Datos a elegir
dt<-c("AMZN")
dt2<-c("TSLA")
#Descargando los valores
data1<- BatchGetSymbols(tickers = dt,
                       first.date = pd,
                       last.date = ld,
                       freq.data = int,
                       do.cache = FALSE,
                       thresh.bad.data = 0)
#Generando data frame con los valores
data_precio_amzn<-data1$df.tickers
colnames(data_precio_amzn)
#>  [1] "ticker"              "ref.date"           
#>  [3] "volume"              "price.open"         
#>  [5] "price.high"          "price.low"          
#>  [7] "price.close"         "price.adjusted"     
#>  [9] "ret.adjusted.prices" "ret.closing.prices"

#necesitamos convertir la serie de tiempo de precios en retornos continuos compuestos de los precios de apertura
data_precio_amzn$ccrAMZN<-c(NA ,100*diff(log(data_precio_amzn$price.open)))#agregamos un valor NA al principio
data_precio_amzn$ccrAMZN#estos son los retornos
#>   [1]           NA   0.37037079  16.90900220  22.83329766
#>   [5] -22.98950701  13.39221448   0.95260416  14.27998202
#>   [9]  11.55626991  24.11122449  -0.46684144  13.08785513
#>  [13]  11.63599301   3.89974592  12.48104071  -0.73260401
#>  [17]  -3.06108260  -4.08140972 -16.32741069   0.99457279
#>  [21]   0.06902105   9.61879412  11.67844638 -33.59147712
#>  [25]  -0.57381482   7.69997922 -18.78100714  15.60691856
#>  [29]  11.66713068  -4.43506452 -20.41392362  -1.23405211
#>  [33]  -6.96531282   9.64353557  -6.77486160  30.02382912
#>  [37]  -5.40177077   6.39945115 -12.58398922  20.12391421
#>  [41]  -2.92703823  -7.77281354 -15.93630872  -2.10477279
#>  [45]  -4.11970307  -1.60415929  10.64572285 -37.21478392
#>  [49]  15.01070027   3.59739571  17.58906665   5.43570463
#>  [53]  -4.00357496  -1.90531667   3.54637914   1.33891100
#>  [57]  42.77167396  11.98170332  -0.13070948  12.66409736
#>  [61]   2.27857959  15.63296023  -6.26135927   2.56510858
#>  [65]   5.74113839 -18.78533471 -21.72447597  13.78662202
#>  [69]   7.15014819   3.44753666 -11.63053849   5.54650897
#>  [73]   8.53074641 -14.71605773 -24.20236452 -29.39126222
#>  [77]  20.09953181  13.15576837   8.77225235  13.27882326
#>  [81]   9.60320128  -2.73678724   7.64068237   2.50334747
#>  [85]  -6.96036997  13.59745291  24.90536163  14.32806129
#>  [89]  -0.50514401 -10.08447333  -3.70473986  13.45839135
#>  [93]   1.02565002  -9.33660068 -13.76436786   8.99531736
#>  [97]   5.87517724  21.76202538   4.58513429   8.56726887
#> [101]   1.22598823  -6.16865517   1.74979032   4.53458328
#> [105]   7.93222740  -0.25978671   4.72685785   9.04110889
#> [109]  -4.41608958   0.80039290  -4.18766494  -8.13529694
#> [113]  -8.68550170  -1.18960511   3.43828044   9.60224827
#> [117]  14.70991690  -9.58159747   9.53799598   2.08880372
#> [121]   5.85976366   2.83140800  -8.65274050   7.52661134
#> [125]   1.39202437   4.89612270  -2.12710012   1.39936277
#> [129]  -5.02332605   5.76221809   3.66491122   8.27850152
#> [133]  -6.24554343   9.85520147  15.15285156   8.73395739
#> [137]  -0.05013788 -10.51934673  -0.06687288  -5.92858190
#> [141] -10.58568315   2.74371861   4.15753522  -3.80625428
#> [145]   8.04816141  -5.42111518  -5.03065911   9.90317538
#> [149]  -7.85404256  11.32156221   8.43295383  -2.32429615
#> [153]  13.01462014   1.54061721   2.05813986  20.15392877
#> [157]  -7.39490376   2.34828935  20.47843365   7.17052347
#> [161]  -2.62563883 -12.67694180  -3.85435390   5.96629237
#> [165]  11.72089295   8.23387458  -0.49783030   5.76252931
#> [169]   1.44112456   8.10699776  -4.52676184  -6.00796092
#> [173]   0.72964776   8.98955770   2.83447462   4.01536256
#> [177]   4.38443827   7.35281333  -2.61760725   2.36894617
#> [181]  -1.20285851  -2.07377928  13.68712240   5.85471090
#> [185]  -0.00427124  20.93976645   4.63815978  -6.55115525
#> [189]   9.77684681   4.61358018   2.75160333   5.84583306
#> [193]  12.74521370  -0.22279328 -21.94794383   8.60716489
#> [197] -18.86826361  11.20213025   0.98664739   8.39682297
#> [201]   7.12720047  -9.38002536   8.85565506  -2.70183034
#> [205]  -5.58782369  -1.36520548   2.37757442   0.91249016
#> [209]   3.83805218   6.98245156  -5.31693095   1.37938043
#> [213]  18.97247680   4.64889431  11.92308161  14.25393454
#> [217]   9.27398656  -8.41337555  -4.66642316   4.05671846
#> [221]   2.52393793  -0.84885499  -3.59427728  -0.31861156
#> [225]  11.12179968  -7.17375312   5.72503641  -2.40180912
#> [229]   4.18486227  -6.11473001   2.18899134   5.30616390
#> [233]  -5.62793333 -11.06465380   1.80527180   7.20896224
#> [237] -29.34750864  -0.11853658 -13.99459654  23.88072732
#> [241]  -6.86965832
#tenemos 20 retornos a lo largo de 20 años
```
Veamos la serie de tiempo

```r
ret_20_amazn<-ggplot(data=data_precio_amzn, aes(x=ref.date))+geom_line(aes(y=ccrAMZN))+labs(title="Retornos de AMZN en los últimos 20 años",y="Retornos", x="Años")+theme_light()
ret_20_amazn
```

<div class="figure">
<img src="06-ESTACIONARIEDAD_files/figure-epub3/amazn20-1.png" alt="Serie de tiempo de los retornos de año en los últimos 20 años"  />
<p class="caption">(\#fig:amazn20)Serie de tiempo de los retornos de año en los últimos 20 años</p>
</div>

### Serie de tiempo

Primero que nada es importante cargar los datos a un objeto series de tiempo. Esto nos lo permite la función ts().
Además debemos serciorarnos de que los datos esten en orden cronológico.

```r
data_precio_amzn<-data_precio_amzn[order(data_precio_amzn$ref.date),]
head(data_precio_amzn)#dado que ya estaba en orden cronológico nuestro df no cambia
#> # A tibble: 6 × 11
#>   ticker ref.date     volume price…¹ price…² price…³ price…⁴
#>   <chr>  <date>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 AMZN   2002-09-25   7.45e8   0.808    0.87   0.764   0.796
#> 2 AMZN   2002-10-01   4.07e9   0.812    1.01   0.800   0.968
#> 3 AMZN   2002-11-01   4.13e9   0.961    1.23   0.91    1.17 
#> 4 AMZN   2002-12-02   3.11e9   1.21     1.25   0.922   0.944
#> 5 AMZN   2003-01-02   3.38e9   0.960    1.16   0.928   1.09 
#> 6 AMZN   2003-02-03   2.32e9   1.10     1.12   0.980   1.10 
#> # … with 4 more variables: price.adjusted <dbl>,
#> #   ret.adjusted.prices <dbl>, ret.closing.prices <dbl>,
#> #   ccrAMZN <dbl>, and abbreviated variable names
#> #   ¹​price.open, ²​price.high, ³​price.low, ⁴​price.close
#hagamos el objeto ts
ret_amazn_ts<-ts(data_precio_amzn$ccrAMZN)
plot(ret_amazn_ts)#de esta manera podemos ver que se cargo bien debido a que es igual al ggplot
```

![](06-ESTACIONARIEDAD_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->

### Estacionariedad


```r
#MA_m5<-forecast::ma(ret_amazn_ts,order=11,centre=TRUE)
#plot(ret_amazn_ts)+lines(MA_m5, col="red", lwd=2)
gglagplot(ret_amazn_ts,lags=20,do.lines=FALSE,colour=FALSE)+theme_minimal()
```

<div class="figure">
<img src="06-ESTACIONARIEDAD_files/figure-epub3/amazn20LAG-1.png" alt="Lag Plot que nos muestra la correlación entre 20 lags"  />
<p class="caption">(\#fig:amazn20LAG)Lag Plot que nos muestra la correlación entre 20 lags</p>
</div>


```r
ACF_ret_amazn_ts<-acf(ret_amazn_ts,na.action = na.pass)
```

<div class="figure">
<img src="06-ESTACIONARIEDAD_files/figure-epub3/amazn20ACF-1.png" alt="Función de Autocorrelación de los retornos de AMZN en los ultimos 20 años"  />
<p class="caption">(\#fig:amazn20ACF)Función de Autocorrelación de los retornos de AMZN en los ultimos 20 años</p>
</div>

La Figura \@ref(fig:amazn20LAG) nos idica la manera en la que se correlacionan los lags, evidentemente no se puede ver ningún tipo de correlacioo1ón visible. Similarmente la Figura \@ref(fig:amazn20ACF) en donde se muestra la función de autocorrelación. Expecto al primer lag --que muestra correlacion debido a que se esta comparando consigo mismo-- es evidente que no hay correlacioo1ón fuerte entre ninguno de los lags. Por lo mismo, sería difícil poder encontrar y estimar valores futuros debido a que la Figura \@ref(fig:amazn20LAG) y la Figura \@ref(fig:amazn20ACF) indican que la serie de tiempo de los retornos de AMZN de la Figura \@ref(fig:amazn20) es __completamente aleatorio y no hay estacionariedad__.
