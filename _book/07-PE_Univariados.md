---
editor_options: 
  markdown: 
    wrap: 72
---

# Procesos estacionarios univariados

En este capítulo analizaremos el método o metodología de análisis de
series de tiempo propuesto por Box y Jenkins (1970). Los modelos
propuestos dentro de está metodología o conjunto de métodos se han
vuelto indispensables para efectos de realizar pronósticos de corto
plazo.

En este sentido, se analizarán los métodos más importantes en series de
tiempo: Autoregresivos (AR) y de Medias Móviles (MA). Asimismo, se
realizará un análisis de los procesos que resultan de la combinación de
ambos, conocida como ARMA, los cuales son más comúnmente usados para
realizar pronósticos.

## Procesos Autoregresivos (AR)

Los procesos autoregresivos tienen su origen en el trabajo de Cochrane y
Orcutt de 1949, mediante el cual analizaron los residuales de una
regresión clásica como un proceso autoregresivo. Puede consultarse el
apéndice para la discusión del modelo de regresión clásica.

### AR(1)

Como primer caso analizaremos al proceso autoregresivo de primer orden,
$AR(1)$, el cual podemos definir como una Ecuación Lineal en Diferencia
Estocástica de Primer Orden. Diremos que una Ecuación Lineal en
Diferencia de Primer Orden es estocástica si en su representación
analítica considera un componente estocástico como en la ecuación
\@ref(eq:EDOEst1) descrita a continuación:

\begin{equation}
    X_t = a_0 + a_1 X_{t-1} + U_t
(\#eq:EDOEst1)
\end{equation}

Donde $a_0$ es un término constante, $U_t$ es un proceso estacionario,
con media cero (0), una varianza finita y constante ($\sigma^2$) y una
covarianza que depende de la distancia entre $t$ y cualquier $t-s$
($\gamma_s$)--que no depende de los valores pasados o futuros de la
variable--, $X_0$ es el valor inicial de $X_t$. No obstante, en general
vamos a asumir que la covarianza será cero (0), por lo que tendremos un
proceso puramente aleatorio. Considerando la ecuación \@ref(eq:EDOEst1) y
un proceso de sustitución sucesivo podemos establecer lo siguiente,
empezando con $X_1$: \begin{eqnarray*}
    X_{1} & = & a_0 + a_1 X_{0} + U_{1}
\end{eqnarray*}

Para $X_2$: \begin{eqnarray*}
X_{2} & = & a_0 + a_1 X_{1} + U_{2} \\
    & = & a_0 + a_1 (a_0 + a_1 X_{0} + U_{1}) + U_{2} \\
    & = & a_0 + a_1 a_0 + a_1^2 X_{0} + a_1 U_{1} + U_{2}
\end{eqnarray*}

Para $X_3$: \begin{eqnarray*}
X_{3} & = & a_0 + \alpha X_{2} + U_{3} \\
    & = & a_0 + a_1 (a_0 + a_1 a_0 + a_1^2 X_{0} + a_1 U_{1} + U_{2}) + U_{3} \\
    & = & a_0 + a_1 a_0 + a_1^2 a_0 + a_1^3 X_{0} + a_1^2 U_{1} + a_1 U_{2} + U_{3}
\end{eqnarray*}

Así, para cualquier $X_t$, $t = 1, 2, 3, \ldots$, obtendríamos:
\begin{eqnarray}
X_{t} & = & a_0 + a_1 X_{t - 1} + U_{t} \nonumber \\
    & = & a_0 + a_1 (a_0 + a_1 a_0 + a_1^2 a_0 + \ldots + a_1^{t-2} a_0 + a_1^{t-1} X_{0} \nonumber \\
    &   & + a_1^{t-2} U_{1} + \ldots + a_1 U_{t - 2} + U_{t - 1}) + U_{t} \nonumber \\
    & = & a_0 + a_1 a_0 + a_1^2 a_0 + a_1^3 a_0 + \ldots + a_1^{t-1} a_0 + a_1^{t} X_{0} \nonumber \\
    &   & + a_1^{t-1} U_{1} + \ldots a_1^2 U_{t - 2} + a_1 U_{t - 1} + U_{t} \nonumber \\
    & = & (1 + a_1 + a_1^2 + a_1^3 + \ldots + a_1^{t-1}) a_0 + a_1^{t} X_{0} \nonumber \\
    &   & + a_1^{t-1} U_{1} + \ldots + a_1^2 U_{t - 2} + a_1 U_{t - 1} + U_{t}  \nonumber\\
    & = & \frac{1 - a_1^t}{1 - a_1} a_0 + a_1^{t} X_{0} + \sum^{t-1}_{j = 0} a_1^{j} U_{t - j} 
    (\#eq:EDOSSol)
\end{eqnarray}

De esta forma en la ecuación \@ref(eq:EDOSSol) observamos un proceso que
es explicado por dos partes: una que depende del tiempo y otra que
depende de un proceso estocástico. Asimismo, debe notarse que la
condición de convergencia es idéntica que en el caso de ecuaciones en
diferencia estudiadas al inicio del curso: $\lvert a_1 \lvert < 1$, por
lo que cuando $t \to \infty$, la expresión \@ref(eq:EDOSSol) será la
siguiente: 

\begin{equation}
    X_t = \frac{1}{1 - a_1} a_0 + \sum^{\infty}_{j = 0} a_1^{j} U_{t - j}
    (\#eq:EDOSLP)
\end{equation}

Así, desaparece la parte dependiente del tiempo y únicamente prevalece
la parte que es dependiente del proceso estocástico. Esta es la solución
de largo plazo del proceso $AR(1)$, la cual depende del proceso
estocástico. Notemos, además, que esta solución implica que la variable
o la serie de tiempo $X_t$ es tambien un proceso estocástico que hereda
las propiedades de $U_t$. Así, $X_t$ es también un proceso estocástico
estacionario, como demostraremos más adelante.

Observemos que la ecuación \@ref(eq:EDOSLP) se puede reescribir si
consideramos la formulación que en la literatura se denomina como la
descomposición de Wold, en la cual se define que es posible asumir que
$\psi_j = a_1^j$ y se considera el caso en el cual
$\lvert a_1 \lvert< 1$, de esta forma tendremos que por ejemplo cuando:
\begin{equation*}
    \sum^{\infty}_{j = 0} \psi^2_j = \sum^{\infty}_{j = 0} a_1^{2j} = \frac{1}{1 - a_1^2} 
\end{equation*}

Alternativamente y de forma similar a las ecuaciones en diferencia
estudiadas previamente podemos escribir el proceso $AR(1)$ mediante el
uso del operador rezago como: 

\begin{eqnarray}
    X_t & = & a_0 + a_1 L X_t + U_t \nonumber \\
    X_t - a_1 L X_t & = & a_0 + U_t \nonumber \\
    (1 - a_1 L) X_t & = & a_0 + U_t \nonumber \\
    X_t & = & \frac{a_0}{1 - a_1 L} + \frac{1}{1 - a_1 L} U_t
    (\#eq:AR1)
\end{eqnarray}

En esta última ecuación retomamos el siguiente término para reescribirlo
como: 

\begin{equation}
    \frac{1}{1 - a_1 L} = 1 + a_1 L + a_1^2 L^2 + a_1^3 L^3 + \ldots
    (\#eq:AR2)
\end{equation}

Tomando este resultado para sustituirlo en ecuación \@ref(eq:AR1),
obtenemos la siguiente expresión: 

\begin{eqnarray}
X_t & = & (1 + a_1 L + a_1^2 L^2 + a_1^3 L^3 + \ldots) a_0 + (1 + a_1 L + a_1^2 L^2 + a_1^3 L^3 + \ldots) U_t \nonumber \\
    & = & (1 + a_1 + a_1^2 + a_1^3 + \ldots) a_0 + U_t + a_1 U_{t-1} + a_1^2 U_{t-2} + a_1^3 U_{t-3} + \ldots \nonumber \\
    & = & \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j U_{t-j}
    (\#eq:AR1Sol)
\end{eqnarray}

Donde la condición de convergencia y estabilidad del proceso descrito en
esta ecuación es que $\lvert a_1 \lvert < 1$. Por lo que hemos
demostrado que mediante el uso del operador de rezago es posible llegar
al mismo resultado que obtuvimos mediante el procedimiento de
sustituciones iterativas.

La ecuación \@ref(eq:AR1Sol) se puede interpretar como sigue. La
solución o trayectoria de equilibrio de un AR(1) se divide en dos
partes. La primera es una constante que depende de los valores de $a_0$
y $a_1$. La segunda parte es la suma ponderada de las desviaciones o
errores observados y acumulados en el tiempo hasta el momento $t$.

Ahora obtendremos los momentos que describen a la serie de tiempo cuando
se trata de un porceso $AR(1)$. Para ello debemos obtener la media, la
varianza y las covarianzas de $X_t$. Para los siguientes resultados
debemos recordar y tener en mente que si $U_t$ es un proceso puramente
aleatorio, entonces:

1.  $\mathbb{E}[U_t] = 0$ para todo $t$
2.  $Var[U_t] = \sigma^2$ para todo $t$
3.  $Cov[U_t, U_s] = 0$ para todo $t \neq s$

Dicho lo anterior y partiendo de la ecuación \@ref(eq:AR1Sol), el primer
momento o valor esperado de la serie de tiempo será el siguiente:
\begin{eqnarray}
\mathbb{E}[X_t] & = & \mathbb{E} \left[ \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j U_{t-j} \right] \nonumber \\
    & = & \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j \mathbb{E}[U_{t-j}] \nonumber \\
    & = & \frac{a_0}{1 - a_1} = \mu
    (\#eq:AR1m1)
\end{eqnarray}

Respecto de la varianza podemos escribir la siguiente expresión a partir
de la ecuación \@ref(eq:AR1Sol): 

\begin{eqnarray}
Var[X_t] & = & \mathbb{E}[(X_t - \mu)^2] \nonumber \\
    & = & \mathbb{E} \left[ \left( \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j U_{t-j} - \frac{a_0}{1 - a_1} \right)^2 \right] \nonumber \\
    & = & \mathbb{E}[(U_{t} + a_1 U_{t-1} + a_1^2 U_{t-2} + a_1^3 U_{t-3} + \ldots)^2] \nonumber \\
    & = & \mathbb{E}[U^2_{t} + a_1^2 U^2_{t-1} + a_1^4 U^2_{t-2} + a_1^6 U^2_{t-3} + \ldots \nonumber \\
    &   & + 2 a_1 U_t U_{t-1} + 2 a_1^2 U_t U_{t-2} + \ldots] \nonumber \\
    & = & \mathbb{E}[U^2_{t}] + a_1^2 \mathbb{E}[U^2_{t-1}] + a_1^4 \mathbb{E}[U^2_{t-2}] + a_1^6 \mathbb{E}[U^2_{t-3}] + \ldots \nonumber \\
    & = & \sigma^2 + a_1^2 \sigma^2 + a_1^4 \sigma^2 + a_1^6 \sigma^2 + \ldots \nonumber \\
    & = & \sigma^2 (1 + a_1^2 + a_1^4 + a_1^6 + \ldots) \nonumber \\
    & = & \sigma^2 \frac{1}{1 - a_1^2} = \gamma(0)
    (\#eq:AR1Var)
\end{eqnarray}

Previo a analizar la covarianza de la serie recordemos que para el
proceso puramente aleatorio $U_t$ su varianza y covarianza puede verse
como $\mathbb{E}[U_t, U_s] = \sigma^2$, para $t = s$, y
$\mathbb{E}[U_t, U_s] = 0$, para cualquier otro caso, respectivamente.

Dicho lo anterior, partiendo de la ecuación \@ref(eq:AR1Sol) la
covarianza de la serie estará dada por: 

\begin{eqnarray}
Cov(X_t, X_{t-\tau}) & = & \mathbb{E}[(X_t - \mu)(X_{t-\tau} - \mu)] \nonumber \\
    & = & \mathbb{E} \left[ \left( \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j U_{t-j} - \frac{a_0}{1 - a_1} \right) \right. \nonumber \\
    &   & \left. \times \left( \frac{a_0}{1 - a_1} + \sum^{\infty}_{j = 0} a_1^j U_{t-\tau-j} - \frac{a_0}{1 - a_1} \right) \right] \nonumber \\
    & = & a_1^{\tau} \mathbb{E}[U^2_{t-\tau} + a_1 U^2_{t-\tau-1} + a_1^2 U^2_{t-\tau-2} + a_1^3 U^2_{t-\tau-3} + \ldots] \nonumber \\
    & = & a_1^{\tau} \sigma^2 \frac{1}{1 - a_1^2} = \gamma(\tau)
    (\#eq:AR1Cov)
\end{eqnarray}

Notése que con estos resultados en las ecuaciones \@ref(eq:AR1Var) y
\@ref(eq:AR1Cov) podemos construir la función de autocorrelación teórica
como sigue: 

\begin{eqnarray}
\rho(\tau) & = & \frac{\gamma(\tau)}{\gamma(0)} \nonumber \\
    & = & a_1^\tau
    (\#eq:emi1)
\end{eqnarray}

Donde $\tau = 1, 2, 3, \ldots$ y $\lvert a_1 \lvert < 1$. Este último
resultado significa que cuando el proceso autoregresivo es de orden 1
(es decir, AR(1)) la función de autocorrelación teóricamente es igual al
parámetro $a_1$ elevado al número de rezagos considerados. No obstante,
note que esto no significa que la autocorrelación observada sea como lo
expresa en planteamiento anterior. Por el contrario, una observación
sencilla mostraría que la autocorrelación observada sería ligeramente
distinta a la autocorrelación teórica.

Ahora veámos algunos ejemplos. En el primer ejemplo simularemos una
serie y mostraremos el analísis de un proceso construído considerando un
proceso puramente aleatorio como componente $U_t$.[^pe_univariados-1]
Por su parte, en un segundo ejemplo aplicaremos el análisis a una serie
de tiempo de una variable económica observada.[^pe_univariados-2]

[^pe_univariados-1]: El procedimiento e implementación del ejercicio
    está en el archivo R denominado Clase 4 del repositorio de GitHub.

[^pe_univariados-2]: El procedimiento e implementación del ejercicio
    está en el archivo R denominado Clase 5 del repositorio de GitHub.

Para el primer ejemplo consideremos un proceso dado por la forma de un
$AR(1)$ como en la ecuación \@ref(eq:AR1) cuya solución esta dada por la
ecuación \@ref(eq:AR1Sol). En especifico, supongamos que el término o
componente estocástico $U_t$ es una serie generada a partir de numeros
aleatorios de una función normal con media $0$ y desviación estándar
$4$. Los detalles del proceso simulado se muestra en las siguientes
gráficas.

#### EJEMPLO AR(1)


```r
library(ggplot2)
library(dplyr)
library(readxl)
library(latex2exp)

# Parametros:
a0 <- 5; a1 <- 0.9; X_0 <- (a0/(1 - a1)); T <- 1000
```

Por lo tanto tenemos la serie de tiempo $AR(1)$:
$$ X_t= 5+0.9X_{t-1}+U_t$$


```r
# Definimos un data frame para almacenar el proceso, agregamos una columna para el tiempo
X_t <- data.frame(Tiempo = c(0:T))

#  Parte estocastica de la serie de tiempo:
set.seed(12345)

# Agregamos un término estocástico al data frame
X_t$U_t <- rnorm(T+1, mean = 0, sd = 4)
```

En este caso el termino estocastico tiene una media de $0$ y una
desviación estándar constante $\sigma^2=4$


```r
# Agregamos columnas con NA's para un proceso teorico y uno real
X_t$X_t <- NA
X_t$XR_t <- NA

# La serie teórica inicia en un valor inicial X_0
X_t$X_t[1] <- X_0

# La serie real inicia en un valor inicial X_0
X_t$XR_t[1] <- X_0

# Agregamos una columna para la función de Autocorrelación teórica:
X_t$rho <-NA

for (i in 2:(T + 1)) {
  # Real:
  X_t$XR_t[i] = a0 + a1*X_t$XR_t[i-1] + X_t$U_t[i-1]
  
  # Teórico:
  X_t$X_t[i] = X_t$X_t[i-1] + (a1^(i-1))*X_t$U_t[i-1]
  
  # Autocorrelación:
  X_t$rho[i-1] = a1^(i-1)
}

head(X_t)
#>   Tiempo        U_t      X_t     XR_t      rho
#> 1      0  2.3421153 50.00000 50.00000 0.900000
#> 2      1  2.8378641 52.10790 52.34212 0.810000
#> 3      2 -0.4372133 54.40657 54.94577 0.729000
#> 4      3 -1.8139887 54.08785 54.01398 0.656100
#> 5      4  2.4235498 52.89769 51.79859 0.590490
#> 6      5 -7.2718239 54.32877 54.04228 0.531441
```


\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1Real-1} 

}

\caption{AR(1) considerando $X_t=5+0.9X_{t-1}+U_t$ ; $X_0=50$ y que $U_t$~$N(0, 4)$ y que $U_t \sim \mathcal{N}(0, 4)$}(\#fig:GAR1Real)
\end{figure}



```r

ggplot(data = X_t, aes(x = Tiempo, y = X_t)) + 
  geom_line(size = 0.5, color = "#0F531C") +
  theme_light() + 
  xlab("Tiempo") + 
  ylab(TeX("$X_t$")) + 
  theme(plot.title = element_text(size = 11, face = "bold", hjust = 0)) + 
  theme(plot.subtitle = element_text(size = 10, hjust = 0)) + 
  theme(plot.caption = element_text(size = 10, hjust = 0)) +
  theme(plot.margin = unit(c(1,1,1,1), "cm")) +
  labs(
    title = "Comportamiento del Proceso Teórico",
    subtitle = "Con un error con Distribución Normal (media = 0, desviación estándar = 4)",
    caption = "Fuente: Elaboración propia."
  )
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1Teo-1} 

}

\caption{$X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$}}(\#fig:GAR1Teo)
\end{figure}



```r

acf(X_t$XR_t, lag.max = 30, col = "blue", 
    ylab = "Autocorrelacion",
    xlab="Rezagos", 
    main="Funcion de Autocorrelacion Real")
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1FACr-1} 

}

\caption{Función de autocorrelación de un AR(1): $\rho(\tau)=\frac{\gamma(	au)}{\gamma(0)}$}(\#fig:GAR1FACr)
\end{figure}


```r

barplot(X_t$rho[1:30], names.arg = c(1:30), col = "blue", border="blue", density = c(10,20), 
        ylab = "Autocorrelacion", 
        xlab="Rezagos", 
        main="Funcion de Autocorrelacion Teórica")
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1FACt-1} 

}

\caption{Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$}(\#fig:GAR1FACt-1)
\end{figure}

```r

acf(X_t$XR_t, lag.max = 30, col = "blue", 
    ylab = "Autocorrelacion",
    xlab="Rezagos", 
    main="Funcion de Autocorrelacion Real")
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1FACt-2} 

}

\caption{Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$}(\#fig:GAR1FACt-2)
\end{figure}


```r

ggplot(data = X_t, aes(x = Tiempo)) +
  geom_line(aes(y = XR_t), size = 0.5, color = "darkred") +
  geom_line(aes(y = X_t), size = 1, color = "#0F531C") +
  theme_bw() + 
  xlab("Tiempo") + 
  ylab(TeX("$X_t$")) + 
  theme(plot.title = element_text(size = 11, face = "bold", hjust = 0)) + 
  theme(plot.subtitle = element_text(size = 10, hjust = 0)) + 
  theme(plot.caption = element_text(size = 10, hjust = 0)) +
  theme(plot.margin = unit(c(1,1,1,1), "cm")) +
  labs(
    title = "Comportamiento de los Procesos Real y Teórico",
    subtitle = "Con un error con Distribución Normal (media = 0, desviación estándar = 4)",
    caption = "Fuente: Elaboración propia."
  )
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{07-PE_Univariados_files/figure-latex/GAR1Com-1} 

}

\caption{AR(1) considerando en conjunto $X_t = 5 + 0.9 X_{t-1} + U_t$; $X_0 = 50$ y $X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$}(\#fig:GAR1Com)
\end{figure}

La Figura \@ref(fig:GAR1Real) ilustra el comportamiento que se debería
observar en una serie considerando el procedimiento iterativo de
construcción. Por su parte, la Figura \@ref(fig:GAR1Teo) ilustra el
proceso o trayectoria de la solución de la serie de tiempo. Finalmente,
las Figuras \@ref(fig:GAR1FACr) y \@ref(fig:GAR1FACr) muestran el
correlograma calculado considerando una función de autocorrelación
aplicada al porceso real y una función de autocorrelación aplicada al
proceso teórico, respectivamente.

Recordemos que una trayectoria de equilibrio o solución de un $AR(1)$ es
como se muestra en la ecuación \@ref(eq:AR1Sol). Así, nuestra serie
simulada cumple con la característica de que los errores son más
relevantes cuando la serie es corta. Por el contrario, los errores son
menos relevantes, cuando la serie es muy larga. La Figura
\@ref(fig:GAR1Com) ilustra esta observación de la trayectoria de
equilibrio.


### AR(2)

Una vez analizado el caso de $AR(1)$ analizaremos el caso del $AR(2)$.
La ecuación generalizada del proceso autoregresivo de orden 2 (denotado
como $AR(2)$) puede ser escrito como: 

\begin{equation}
    X_t = a_0 + a_1 X_{t-1} + a_2 X_{t-2} + U_t
    (\#eq:AR2Eq)
\end{equation}


Para el segundo ejemplo consideremos una aplicación a una serie de
tiempo en especifico:

#### EJEMPLO AR(2)

Recordando el tema pasado y la serie en la que evaluamos los cambios de
precio del ACTIVO AMZN como si fueran retornos:


```r
#install.packages("pacman")
#pacman nos permite cargar varias librerias en una sola línea
library(pacman)
pacman::p_load(tidyverse,BatchGetSymbols,ggplot2,lubridate,readxl,forecast,stats,stargazer)
```


```r
#Primero determinamos el lapso de tiempo
pd<-Sys.Date()-(365*20) #primer fecha
pd
#> [1] "2002-10-02"
ld<-Sys.Date() #última fecha
ld
#> [1] "2022-09-27"
#Intervalos de tiempo
int<-"monthly"
#Datos a elegir
dt<-c("AMZN")
#Descargando los valores
data1<- BatchGetSymbols(tickers = dt,
                       first.date = pd,
                       last.date = ld,
                       freq.data = int,
                       do.cache = FALSE,
                       thresh.bad.data = 0)
#> Warning: `BatchGetSymbols()` was deprecated in BatchGetSymbols 2.6.4.
#> Please use `yfR::yf_get()` instead.
#> 2022-05-01: Package BatchGetSymbols will soon be replaced by yfR. 
#> More details about the change is available at github <<www.github.com/msperlin/yfR>
#> You can install yfR by executing:
#> 
#> remotes::install_github('msperlin/yfR')
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
#>   [1]           NA  13.39774561  22.83329766 -22.98950701
#>   [5]  13.39221448   0.95260416  14.27998202  11.55626991
#>   [9]  24.11122449  -0.46684144  13.08785513  11.63599301
#>  [13]   3.89974592  12.48104071  -0.73260401  -3.06108260
#>  [17]  -4.08140972 -16.32741069   0.99457279   0.06902105
#>  [21]   9.61879412  11.67844638 -33.59147712  -0.57381482
#>  [25]   7.69997922 -18.78100714  15.60691856  11.66713068
#>  [29]  -4.43506452 -20.41392362  -1.23405211  -6.96531282
#>  [33]   9.64353557  -6.77486160  30.02382912  -5.40177077
#>  [37]   6.39945115 -12.58398922  20.12391421  -2.92703823
#>  [41]  -7.77281354 -15.93630872  -2.10477279  -4.11970307
#>  [45]  -1.60415929  10.64572285 -37.21478392  15.01070027
#>  [49]   3.59739571  17.58906665   5.43570463  -4.00357496
#>  [53]  -1.90531667   3.54637914   1.33891100  42.77167396
#>  [57]  11.98170332  -0.13070948  12.66409736   2.27857959
#>  [61]  15.63296023  -6.26135927   2.56510858   5.74113839
#>  [65] -18.78533471 -21.72447597  13.78662202   7.15014819
#>  [69]   3.44753666 -11.63053849   5.54650897   8.53074641
#>  [73] -14.71605773 -24.20236452 -29.39126222  20.09953181
#>  [77]  13.15576837   8.77225235  13.27882326   9.60320128
#>  [81]  -2.73678724   7.64068237   2.50334747  -6.96036997
#>  [85]  13.59745291  24.90536163  14.32806129  -0.50514401
#>  [89] -10.08447333  -3.70473986  13.45839135   1.02565002
#>  [93]  -9.33660068 -13.76436786   8.99531736   5.87517724
#>  [97]  21.76202538   4.58513429   8.56726887   1.22598823
#> [101]  -6.16865517   1.74979032   4.53458328   7.93222740
#> [105]  -0.25978671   4.72685785   9.04110889  -4.41608958
#> [109]   0.80039290  -4.18766494  -8.13529694  -8.68550170
#> [113]  -1.18960511   3.43828044   9.60224827  14.70991690
#> [117]  -9.58159747   9.53799598   2.08880372   5.85976366
#> [121]   2.83140800  -8.65274050   7.52661134   1.39202437
#> [125]   4.89612270  -2.12710012   1.39936277  -5.02332605
#> [129]   5.76221809   3.66491122   8.27850152  -6.24554343
#> [133]   9.85520147  15.15285156   8.73395739  -0.05013788
#> [137] -10.51934673  -0.06687288  -5.92858190 -10.58568315
#> [141]   2.74371861   4.15753522  -3.80625428   8.04816141
#> [145]  -5.42111518  -5.03065911   9.90317538  -7.85404256
#> [149]  11.32156221   8.43295383  -2.32429615  13.01462014
#> [153]   1.54061721   2.05813986  20.15392877  -7.39490376
#> [157]   2.34828935  20.47843365   7.17052347  -2.62563883
#> [161] -12.67694180  -3.85435390   5.96629237  11.72089295
#> [165]   8.23387458  -0.49783030   5.76252931   1.44112456
#> [169]   8.10699776  -4.52676184  -6.00796092   0.72964776
#> [173]   8.98955770   2.83447462   4.01536256   4.38443827
#> [177]   7.35281333  -2.61760725   2.36894617  -1.20285851
#> [181]  -2.07377928  13.68712240   5.85471090  -0.00427124
#> [185]  20.93976645   4.63815978  -6.55115525   9.77684681
#> [189]   4.61358018   2.75160333   5.84583306  12.74521370
#> [193]  -0.22279328 -21.94794383   8.60716489 -18.86826361
#> [197]  11.20213025   0.98664739   8.39682297   7.12720047
#> [201]  -9.38002536   8.85565506  -2.70183034  -5.58782369
#> [205]  -1.36520548   2.37757442   0.91249016   3.83805218
#> [209]   6.98245156  -5.31693095   1.37938043  18.97247680
#> [213]   4.64889431  11.92308161  14.25393454   9.27398656
#> [217]  -8.41337555  -4.66642316   4.05671846   2.52393793
#> [221]  -0.84885499  -3.59427728  -0.31861156  11.12179968
#> [225]  -7.17375312   5.72503641  -2.40180912   4.18486227
#> [229]  -6.11473001   2.18899134   5.30616390  -5.62793333
#> [233] -11.06465380   1.80527180   7.20896224 -29.34750864
#> [237]  -0.11853658 -13.99459654  23.88072732  -6.86965832
#tenemos 20 retornos a lo largo de 20 años
```


```r
ret_20_amazn<-ggplot(data=data_precio_amzn, aes(x=ref.date))+geom_line(aes(y=ccrAMZN))+labs(title="Retornos de AMZN en los últimos 20 años",y="Retornos", x="Año")+theme_light()
ret_20_amazn
```

![(\#fig:amazn20)Serie de tiempo de los retornos de año en los últimos 20 años](07-PE_Univariados_files/figure-latex/amazn20-1.pdf) 


Primero que nada es importante cargar los datos a un objeto series de
tiempo. Esto nos lo permite la función ts(). Además debemos serciorarnos
de que los datos esten en orden cronológico.


```r
data_precio_amzn<-data_precio_amzn[order(data_precio_amzn$ref.date),]
head(data_precio_amzn)#dado que ya estaba en orden cronológico nuestro df no cambia
#> # A tibble: 6 x 11
#>   ticker ref.date     volume price~1 price~2 price~3 price~4
#>   <chr>  <date>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 AMZN   2002-10-02   3.89e9   0.840    1.01   0.818   0.968
#> 2 AMZN   2002-11-01   4.13e9   0.961    1.23   0.91    1.17 
#> 3 AMZN   2002-12-02   3.11e9   1.21     1.25   0.922   0.944
#> 4 AMZN   2003-01-02   3.38e9   0.960    1.16   0.928   1.09 
#> 5 AMZN   2003-02-03   2.32e9   1.10     1.12   0.980   1.10 
#> 6 AMZN   2003-03-03   3.28e9   1.11     1.40   1.07    1.30 
#> # ... with 4 more variables: price.adjusted <dbl>,
#> #   ret.adjusted.prices <dbl>, ret.closing.prices <dbl>,
#> #   ccrAMZN <dbl>, and abbreviated variable names
#> #   1: price.open, 2: price.high, 3: price.low,
#> #   4: price.close
#hagamos el objeto ts
ret_amazn_ts<-ts(data_precio_amzn$ccrAMZN)
plot(ret_amazn_ts)#de esta manera podemos ver que se cargo bien debido a que es igual al ggplot
```

![](07-PE_Univariados_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

Dado que queremos saber si existe un proceso AR(2) en estos cambio
debemos calcularlo. Para ello utilizamos la función lm() que realizará una regresión lineal y veremos la relación de los valores con sus valores pasados en $t-2$:


```r
priceopen<-data_precio_amzn$price.open
priceopen_amazn<-as.data.frame(priceopen)
priceopen_amazn$priceopen_lag1<-lag(priceopen_amazn$priceopen,1)
priceopen_amazn$priceopen_lag2<-lag(priceopen_amazn$priceopen,2)
ar2_amazn<-lm(priceopen~priceopen_lag1+priceopen_lag2, data=priceopen_amazn)
```

Veamos la tabla de la regresión lineal:


```r
stargazer(
  ar2_amazn,
  type = "html",
  notes.align = "l", style="all", notes.append = FALSE,star.char=c("*"), notes=c("(p<0.1)=[*], (p<0.05)=[**], (p<0.01)=[***]"), title ="AR(2) de los precios de apertura de AMZN", label = "tab:Ar2precios")
```


<table style="text-align:center"><caption><strong>AR(2) de los precios de apertura de AMZN</strong></caption>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="1" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>priceopen</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">priceopen_lag1</td><td>0.840<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.065)</td></tr>
<tr><td style="text-align:left"></td><td>t = 12.968</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td></tr>
<tr><td style="text-align:left">priceopen_lag2</td><td>0.161<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.065)</td></tr>
<tr><td style="text-align:left"></td><td>t = 2.468</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.015</td></tr>
<tr><td style="text-align:left">Constant</td><td>0.580</td></tr>
<tr><td style="text-align:left"></td><td>(0.460)</td></tr>
<tr><td style="text-align:left"></td><td>t = 1.261</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.209</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>238</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.988</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.987</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>5.696 (df = 235)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>9,358.762<sup>***</sup> (df = 2; 235) (p = 0.000)</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td style="text-align:left">(p<0.1)=[*], (p<0.05)=[**], (p<0.01)=[***]</td></tr>
</table>

La Tabla anterior claramente indica que __hay una
relación entre el valor del precio y sus valores anteriores en un
proceso AR(2)__.
