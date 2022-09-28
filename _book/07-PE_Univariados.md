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


<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1Real-1.png" alt="AR(1) considerando $X_t=5+0.9X_{t-1}+U_t$ ; $X_0=50$ y que $U_t$~$N(0, 4)$ y que $U_t \sim \mathcal{N}(0, 4)$" width="100%" />
<p class="caption">(\#fig:GAR1Real)AR(1) considerando $X_t=5+0.9X_{t-1}+U_t$ ; $X_0=50$ y que $U_t$~$N(0, 4)$ y que $U_t \sim \mathcal{N}(0, 4)$</p>
</div>



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

<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1Teo-1.png" alt="$X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$}" width="100%" />
<p class="caption">(\#fig:GAR1Teo)$X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$}</p>
</div>



```r

acf(X_t$XR_t, lag.max = 30, col = "blue", 
    ylab = "Autocorrelacion",
    xlab="Rezagos", 
    main="Funcion de Autocorrelacion Real")
```

<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1FACr-1.png" alt="Función de autocorrelación de un AR(1): $\rho(\tau)=\frac{\gamma(	au)}{\gamma(0)}$" width="100%" />
<p class="caption">(\#fig:GAR1FACr)Función de autocorrelación de un AR(1): $\rho(\tau)=\frac{\gamma(	au)}{\gamma(0)}$</p>
</div>


```r

barplot(X_t$rho[1:30], names.arg = c(1:30), col = "blue", border="blue", density = c(10,20), 
        ylab = "Autocorrelacion", 
        xlab="Rezagos", 
        main="Funcion de Autocorrelacion Teórica")
```

<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1FACt-1.png" alt="Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$" width="100%" />
<p class="caption">(\#fig:GAR1FACt-1)Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$</p>
</div>

```r

acf(X_t$XR_t, lag.max = 30, col = "blue", 
    ylab = "Autocorrelacion",
    xlab="Rezagos", 
    main="Funcion de Autocorrelacion Real")
```

<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1FACt-2.png" alt="Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$" width="100%" />
<p class="caption">(\#fig:GAR1FACt-2)Función de autocorrelación de un AR(1): $\rho(\tau)= a_1^\tau$</p>
</div>


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

<div class="figure" style="text-align: center">
<img src="07-PE_Univariados_files/figure-html/GAR1Com-1.png" alt="AR(1) considerando en conjunto $X_t = 5 + 0.9 X_{t-1} + U_t$; $X_0 = 50$ y $X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$" width="100%" />
<p class="caption">(\#fig:GAR1Com)AR(1) considerando en conjunto $X_t = 5 + 0.9 X_{t-1} + U_t$; $X_0 = 50$ y $X_t = \frac{5}{1 - 0.9} + \sum_{j = 0}^{t-1} 0.9^j U_{t-j}$, y que $U_t \sim \mathcal{N}(0, 4)$</p>
</div>

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
#> [1] "2002-10-03"
ld<-Sys.Date() #última fecha
ld
#> [1] "2022-09-28"
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
```


```r
ret_20_amazn<-ggplot(data=data_precio_amzn, aes(x=ref.date))+
  geom_line(aes(y=price.open))+
  labs(title="Precios de apertura de AMZN en los últimos 20 años",y="Retornos", x="Año")+
  theme_light()
ret_20_amazn
```

<div class="figure">
<img src="07-PE_Univariados_files/figure-html/amazn20-1.png" alt="Serie de tiempo de los precios de apertura de año en los últimos 20 años" width="672" />
<p class="caption">(\#fig:amazn20)Serie de tiempo de los precios de apertura de año en los últimos 20 años</p>
</div>


Primero que nada es importante cargar los datos a un objeto series de
tiempo. Esto nos lo permite la función ts(). Además debemos serciorarnos
de que los datos esten en orden cronológico.


```r
data_precio_amzn<-data_precio_amzn[order(data_precio_amzn$ref.date),]
head(data_precio_amzn)#dado que ya estaba en orden cronológico nuestro df no cambia
#> # A tibble: 6 × 10
#>   ticker ref.date     volume price…¹ price…² price…³ price…⁴
#>   <chr>  <date>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 AMZN   2002-10-03   3.72e9   0.840    1.01   0.818   0.968
#> 2 AMZN   2002-11-01   4.13e9   0.961    1.23   0.91    1.17 
#> 3 AMZN   2002-12-02   3.11e9   1.21     1.25   0.922   0.944
#> 4 AMZN   2003-01-02   3.38e9   0.960    1.16   0.928   1.09 
#> 5 AMZN   2003-02-03   2.32e9   1.10     1.12   0.980   1.10 
#> 6 AMZN   2003-03-03   3.28e9   1.11     1.40   1.07    1.30 
#> # … with 3 more variables: price.adjusted <dbl>,
#> #   ret.adjusted.prices <dbl>, ret.closing.prices <dbl>,
#> #   and abbreviated variable names ¹​price.open,
#> #   ²​price.high, ³​price.low, ⁴​price.close
#hagamos el objeto ts
price_amazn_ts<-ts(data_precio_amzn$price.open)
plot(price_amazn_ts)#de esta manera podemos ver que se cargo bien debido a que es igual al ggplot
```

<img src="07-PE_Univariados_files/figure-html/unnamed-chunk-6-1.png" width="672" />

Dado que queremos saber si existe un proceso $AR(2)$ en estos cambio
debemos calcularlo. Para ello utilizamos la función $lm()$ que realizará una regresión lineal y veremos la relación de los valores con sus valores pasados en $t-2$:


```r
priceopen<-data_precio_amzn$price.open
priceopen_amazn<-as.data.frame(priceopen)
priceopen_amazn$priceopen_lag1<-lag(priceopen_amazn$priceopen,1)
priceopen_amazn$priceopen_lag2<-lag(priceopen_amazn$priceopen,2)
ar2_amazn<-lm(priceopen~priceopen_lag1+priceopen_lag2, data=priceopen_amazn)
```

Veamos la tabla de la regresión lineal:


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
<tr><td style="text-align:left">F Statistic</td><td>9,358.763<sup>***</sup> (df = 2; 235) (p = 0.000)</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td style="text-align:left">(p<0.1)=[*], (p<0.05)=[**], (p<0.01)=[***]</td></tr>
</table>

La tabla anterior claramente indica que **hay una relación entre el valor del precio y sus valores anteriores en un proceso AR(2)**.

Así pues es importante modificar la serie de tiempo para ilustrar como se puede controlar los efectos de los autoregresores $AR(2)$. Para ello, utilizaremos la función $arima()$. En "order" tenemos un vector $c(p,d,q)$ que corresponde $p$ a el grado de AR, $d$ el grado de diferención y $q$ el grado de MA que utilizaremos. El valor $q$ quedaráá en $0$ por ahora pero será analizado más adelante.


```r
AR_price_amazn_ts<-Arima(price_amazn_ts,order=c(2,0,0),method = "ML")
```
Veamos si las raices inversas mantienen la estabilidad al ser menores a 1.

```r
comp_20_amazn<-autoplot(AR_price_amazn_ts, main = "Raices AR(2)")+theme_light()
comp_20_amazn
```

<div class="figure">
<img src="07-PE_Univariados_files/figure-html/amazn20root-1.png" alt="Raices AR(2) Inversas de la serie de tiempo" width="672" />
<p class="caption">(\#fig:amazn20root)Raices AR(2) Inversas de la serie de tiempo</p>
</div>
Claramente se puede en la Figura \@ref(fig:amazn20root) ver que los valores de las raices inversas están dentro del circulo unitario y, por consiguiente son menores a 1. Ahora veamos como se ve la estimación ajustada AR(2) con el plot original.


```r
plot(AR_price_amazn_ts$x,col="black", main = "Diferencia entre la serie de tiempo original y AR(2)",xlab="Tiempo",ylab="Precio")+lines(fitted(AR_price_amazn_ts),col="blue")
```

<div class="figure">
<img src="07-PE_Univariados_files/figure-html/amazn20AR2-1.png" alt="Diferencia entre la serie de tiempo original de precios de AMZN y su AR(2)" width="672" />
<p class="caption">(\#fig:amazn20AR2)Diferencia entre la serie de tiempo original de precios de AMZN y su AR(2)</p>
</div>

```
#> integer(0)
```
Consecuentemente en la Figura \@ref(fig:amazn20AR2) es pocible ver la manera en la que se suaviza un poco la línea lo cual debe ayudarnos a hacer una mejor estimación. 




