# SETAR-STAR-LINEAR-TEST

## SETAR Y STAR

Como lo estudiamos en el capitulo anterior, existen muchos modelos de cambio de régimen.
Otro de los modelos más utilizados es el _Self-Exciting Threshold Autorregressive model_ o (SETAR) por sus siglas. Este modelo se denota de la siguiente manera, veamos AR(1):

\begin{equation}
y_t = \left\lbrace
\begin{array}{ll}
\phi_{0,1}+\phi_{1,1}y_{t-1}+\epsilon_t\mathrm{ si }  y_{t-1}\leq c\\
\phi_{0,2}+\phi_{1,2}y_{t-1}+\epsilon_t\mathrm{ si }  y_{t-1}>c
\end{array}
\right.
\end{equation}

Donde c representa un limite el cual determina el régimen en el que nos encontramos y $\epsilon$ es una serie de ruido blanco condicional a la historia que esta denotada por $\Omega_{t-1}=(y_{t-1},y_{t-2}, \dots, y_{1-(p-1)}, y_{t-p})$ y su valor esperado $E[\epsilon_t|\Omega_{t-1}]=0$ y $E[\epsilon_t^2|\Omega_{t-1}]=\sigma^2$.

Queda claro que el cambio se hace de manera discreta; sin embargo, se puede construir un modelo continuo donde se construye un indicador contiunuo $G(y_t-1;\gamma,c)$ que cambia suavizadamente a  de 0 a 1 cuando $y_{t-1}$ aumenta. Se ve así y se le conoce como __Smooth Transition Auto-Regressive Model__ (STAR):

\begin{equation}
    y_t=(\phi_{0,1}+\phi_{1,1}y_{t-1})(1-G(y_t-1;\gamma,c)+ y_t=(\phi_{0,2}+\phi_{1,2}y_{t-1})(G(y_t-1;\gamma,c))
\end{equation}

En práctica realmente no siempre se utilizan modelos de AR(1), por lo mismo de órdenes más altos vemos:
    \begin{equation}
y_t = \left\lbrace
\begin{array}{ll}
\phi_{0,1}+\phi_{1,1}y_{t-1}+\dots+\phi_{p_{1},1}y_{t-p_1}+\epsilon_t\mathrm{ si }  y_{t-1}\leq c\\
\phi_{0,2}+\phi_{1,2}y_{t-1}+\dots+\phi_{p_{2},2}y_{t-p_2}+\epsilon_t\mathrm{ si }  y_{t-1}>c
\end{array}
\right.
\end{equation}

SETAR(p) se ve así:

\begin{equation}
 
   y_t=(\phi_{0,1}+\phi_{1,1}y_{t-1}+\dots+\phi_{p_{1},1}y_{t-p_1})(1-G(y_t-1;\gamma,c)+ y_t=(\phi_{0,2}+\phi_{1,2}y_{t-1}+\dots+\phi_{p_{2},2}y_{t-p_2})(G(y_t-1;\gamma,c))
\end{equation}

## Pruebas de detección lineal.

### Test SETAR

Concretamente, utilizamos los estimados del modelo SETAR para definir F que comprueba las restricciones de la hipótesis nula.
    \begin{equation}
        F(\hat{c})=n\left(\frac{\tilde{\sigma^2}-\hat{\sigma^2}}{\hat{\sigma^2}} \right)
    \end{equation}
Donde $\tilde{\sigma^2}$ es un estimado de la varianza residual. $\tilde{\sigma^2}=\sum a_{t=1}^n\tilde{\varepsilon^2_t}$ donde $\tilde{\varepsilon^2_t}=y_t-\hat{\phi^{'}}x_t$ y $\hat{\sigma^2}=\sum a_{t=1}^n\hat{\varepsilon^2_t}(c)$.

### Test STAR

 Aprovechando este test, resulta relevante tomar en cuenta variables problematicas que pueden colapsar un STAR a un simple AR. L hipótesis nula se puede expresar $H_0:\gamma=0$. Tambien si $\gamma=0$ entonces:
    \begin{equation}
        G(y_{t-1};\gamma,c)=\frac{1}{1+exp(-\gamma[t_{t-1}-c])}
    \end{equation}
    $G(y_{t-1};\gamma,c)=0.5$ para todo $x_t$ y los parámetros son iguales a $(\phi_1+\phi_2)/2$. Los parámetros $\gamma$ y $c$ pueden ser problemáticos y difíciles de identificar. Para resolver este problema se utiliza el Multiplicado de Lagrange (LM) que tiene una distribuscion $\chi^2$.
    El modelo STAR se puede reescribir:
    \begin{equation}
            (\#eq:mdstar)
    y_t=\frac{1}{2}(\phi_1+\phi_2)^{'}x_t+(\phi_2-\phi_1)^{'}x_tG^{*}(y_{t-1};\gamma,c)+\epsilon_t
\end{equation}
Donde $G^{*}(y_{t-1};\gamma,c)=G(y_{t-1};\gamma,c)-\frac{1}{2}$. La hipotesis nula hace que $G^{*}(y_{t-1};\gamma,c)=0$.  Si hacemos una aproximación de Taylor de $G^{*}(y_{t-1};\gamma,c)$:
\begin{eqnarray}
    T_1(t_{t-1};c)&\approx& G^{*}(y_{t-1};0,c)+\gamma\frac{\partial G^{*}(y_{t-1};\gamma,c)}{\partial\gamma}\bigg|_{\gamma=0}\\
    &=&\frac{1}{4}\gamma(y_{t-1}-c)
\end{eqnarray}


 Metiendo $T_1$ en $G_1^*$ obtenemos una regresión auxiliar.
    \begin{equation}
    (\#eq:regaux)
    y_t=\beta_{0,0}+\beta_0^{'}\tilde{x_t}+\beta_1^{'}\tilde{x_t}y_{t-1}+\eta
    \end{equation}
Donde $tilde{x_t}=(y_{t-1},\dots,y_{t-p})^{'}$ y $\beta_j=(\beta_{1,j},\dots,\beta_{p,j})^{'}$. La relación entre \@ref(eq:mdstar) y \@ref(eq:regaux) se ve:

\begin{eqnarray}
    \beta_{0,0}&=&(\phi_{0,1}+\phi_{0,2})/2-\frac{1}{4}\gamma c\gamma c(\phi_{0,2}-\phi_{0,1})\\
    \beta_{1,0}&=&(\phi_{1,1}+\phi_{1,2})/2-\frac{1}{4}\gamma (c(\phi_{1,2}-\phi_{1,1})-(\phi_{0,2}-\phi_{0,1}))\\
    \beta_{i,0}&=&(\phi_{i,1}+\phi_{i,2})/2-\frac{1}{4}\gamma c\gamma c(\phi_{i,2}-\phi_{i,1}),\quad i=2,\dots,p\\
    \beta_{i,1}&=&\gamma c\frac{1}{4}\gamma c(\phi_{i,2}-\phi_{i,1}),\quad i=1,\dots,p
\end{eqnarray}
En las ecuaciones de arriba podemos ver que si $\gamma=0$ en \@ref(eq:mdstar), entonces $\beta_{i,1}=0$ en \@ref(eq:regaux). Lo cual se refiere a nuestra variable de prueba en la \textbf{hipótesis nula}.$H_0^{'}:\gamma=0$ y $H_0^{''}:\beta_1=0$  Esto se distribuye como $\chi^2$ con $p$ grados de libertad. 

 Finalmente hay que hacer una especificación en la que se permite que el intercepto sea diferente, pero los coeficientes no. Es decir, $\phi_{0,1}\neq\phi_{0,2}$, pero $\phi_{i,1}=\phi_{i,2}$ donde $i=1,\dots,p$. Por su parte $G(y_{t-1};\gamma,c)$ es:
    \begin{eqnarray}
        T_3(y_{t-1};\gamma,c)&\approx&\gamma\frac{\partial G^{*}(y_{t-1};\gamma,c))}{\partial\gamma}\bigg|_{\gamma=0}+\frac{1}{6}\gamma^3\frac{\partial^3 G^{*}(y_{t-1};\gamma,c))}{\partial\gamma^3}\bigg|_{\gamma=0}\\
        &=&\frac{1}{4}\gamma(y_{t-1}-c)+\frac{1}{48}\gamma^3(y_{t-1}-c)^3
    \end{eqnarray}
    El modelo auxiliar se ve de la siguiente manera cuando evaluamos en 0.
    \begin{equation}
        (\#eq:regaux)
        y_t=\beta_{0,0}+\beta_0^{'}\tilde{x_t}+\beta_1^{'}\tilde{x_t}y_{t-1}+\beta_2^{'}\tilde{x_t}y_{t-2}+\beta_3^{'}\tilde{x_t}y_{t-3}+\eta_t.
    \end{equation}
De esta manera las pruebas son $H_0^{'}:\gamma=0$ y $H_0^{''}:\beta_1=\beta_2=\beta_3=0$ con distribución $\chi^2$ y $3p$ grados de libertad.

 Finalmente hay que hacer una especificación en la que se permite que el intercepto sea diferente, pero los coeficientes no. Es decir, $\phi_{0,1}\neq\phi_{0,2}$, pero $\phi_{i,1}=\phi_{i,2}$ donde $i=1,\dots,p$. Por su parte $G(y_{t-1};\gamma,c)$ es:
    \begin{eqnarray}
        T_3(y_{t-1};\gamma,c)&\approx&\gamma\frac{\partial G^{*}(y_{t-1};\gamma,c))}{\partial\gamma}\bigg|_{\gamma=0}+\frac{1}{6}\gamma^3\frac{\partial^3 G^{*}(y_{t-1};\gamma,c))}{\partial\gamma^3}\bigg|_{\gamma=0}\\
        &=&\frac{1}{4}\gamma(y_{t-1}-c)+\frac{1}{48}\gamma^3(y_{t-1}-c)^3
    \end{eqnarray}
    El modelo auxiliar se ve de la siguiente manera cuando evaluamos en 0.
    \begin{equation}
    (\#eq:regaux)
    y_t=\beta_{0,0}+\beta_0^{'}\tilde{x_t}+\beta_1^{'}\tilde{x_t}y_{t-1}+\beta_2^{'}\tilde{x_t}y_{t-2}+\beta_3^{'}\tilde{x_t}y_{t-3}+\eta_t.
    \end{equation}
De esta manera las pruebas son $H_0^{'}:\gamma=0$ y $H_0^{''}:\beta_1=\beta_2=\beta_3=0$ con distribución $\chi^2$ y $3p$ grados de libertad.

 El F test se puede computar 
- Estimar el modelo de la hipótesis nula regresando $y_t$ en $x_t$ y computar los residuales $\tilde{\epsilon}$ y el SSR (suma de residos al cuadrado: $SSR_0=\sum_{t=1}^n\tilde{\epsilon}^2$
-  Estimamos la regression auxiliar de $\tilde{\epsilon}$ en $x_t$ y $\tilde{x_t}y_{t-1}^j$ donde $j=1,2,3$ y obtener la suma de los errores al cuadrado $SSR_1$.
- Finalmente:
    \begin{equation}
        LM=\frac{(SSR_0-SSR_1)/3p}{SSR/(n-4p-1}
    \end{equation}

### Test MARKOV
 Ahora veamos el modelo de cambio de régimen de Markov. El test necesita de $h_t(\theta)$ que esta definido por la derivada del logaritmo de la densidad condicional definida como $f(y_t|\Omega_{t-1};\theta)$.
    
\begin{eqnarray}
    f(y_t|\Omega_{t-1};\theta)&=&f(y_t,st=1|\Omega_{t-1};\theta)+f(y_t,st=2|\Omega_{t-1};\theta)\\
    (\#eq:denscon)
    &=& \sum_{j=1}^2f(y_t,st=j|\Omega_{t-1};\theta)\cdot P(y_t|\Omega_{t-1};\theta)
\end{eqnarray}
\begin{equation}
    h_t(\theta)\equiv \frac{\partial ln[f(y_t|\Omega_{t-1};\theta)]}{\partial\theta}
\end{equation}
Para dos regímenes:
\tiny{
\begin{eqnarray}
    \frac{\partial ln[f(y_t|\Omega_{t-1};\theta)]}{\partial\theta}=\frac{1}{\sigma^2}(y_t-\phi^{'}_jx_t)x_t\cdot P(st=j|\Omega)+\frac{1}{\sigma^2}(y_{\tau}-\phi^{'}_jx_{\tau})x_{\tau}\cdot (P(st=j|\Omega_t;\theta)-P(st=j|\Omega_{t-1};\theta)
\end{eqnarray}

Por construcción, el resultado evaluado por ML estima $\hat{\theta}$ tiene media cero. $\sum_{t-1}^nh_t(\hat{\theta})$.

 Por lo mismo, se construye las estadísticas LM. Para dos regímenes agregamos variables $z_t$ que se han omitido y queremos probar contra la alternativa:
    \begin{equation}
        y_t=\phi_{0,s_t}+\phi_{1,s_t}y_{t-1}+\dots+\phi_{p,s_t}y_{t-p}+\delta^{'}z_t+\epsilon_t.
    \end{equation}
La ecuación evaluada respecto a $\delta$ --que es un vector de variable omitidas-- construye la hipótesis $H_0:\delta=0$ es igual a:

\begin{equation}
    \frac{\partial ln[f(y_t|\Omega_{t-1};\theta)]}{\partial\theta}\bigg|_{\delta=0}=\sum_{j=1}^2(y_t-\phi_j^{'}x_t)z_t\cdot P(s_t=j|\Omega_n;\hat{\theta})
\end{equation}
Donde \hat{\theta} estima el vector $\theta^{'}=(\phi_1{'},\phi_2,p_{11},p_{22},\delta)$ debajo la hipótesis nula. Por lo mismo LM se obtiene con:
\begin{equation}
    n\left(\frac{1}{n}\sum_{t=1}^nh_t(\hat{\theta)}\right)^{'}\left(\frac{1}{n}\sum_{t=1}^nh_t(\hat{\theta})h_t(\hat{\theta}^{'})\right)\left(\frac{1}{n}\sum_{t=1}^nh_t(\hat{\theta})\right)
\end{equation}
se distribuye asintóticamente $\chi^2$ con el número de variables en $z_t$.

### Test GARCH

 El test está basado en el modelo de ARCH(q). La varianza condicional es constante si los parámetros de los residuos al cuadrado ($\epsilon_{t-1}^2,i=1,\dots,q$) son iguales a cero. Por tanto, la hipótesis nula de la heterocedasticidad condicional es $H_0:\alpha_1=\dots=\alpha_q$. El LM correspondiente se computa como $nR^2$ donde n es la cantidad de datos y $R^2$ se obtiene de de la regresión de los residuos al cuadrado respecto a los $q$ lags constantes:
    
\begin{equation}
\hat{\epsilon_t^2}=\omega+\alpha_1\hat{\epsilon_{t-1}^2}+\dots+\alpha_p\hat{\epsilon_{t-p}^2}+u_t
\end{equation}
    
Por lo que donde los residuales $\hat{\epsilon_t^2}$ se obtienen del  del modelo de media condicional de la serie de tiempo observada. Se distribuye $\chi^2(q)$. Este test es equivalente a hacer uno para el GARCH(p,q)
