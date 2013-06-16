% Клас для форматування магістерської дисертації.
% ************************ ТАВРОВ Д.Ю. *************************
% ************************* 10.06.13 ***************************

% 1. Ідентифікуємо клас
\ProvidesClass{diploma}% ім'я класу
    [2013/06/10 v1.0 Клас для створення магістерської дисертації]% опис класу

\NeedsTeXFormat{LaTeX2e} % потрібний формат


% 2. Завантажуємо "батьківський клас"
\LoadClass[a4paper,14pt,ukrainian,oneside]{extreport}


% 3. Завантажуємо пакети
% мовні пакети
\RequirePackage{extsizes}
\RequirePackage{cmap}% для кодування шрифтів у pdf
\RequirePackage[T2A]{fontenc} % пакет для підтримки кирилічних шрифтів
% \DeclareSymbolFont{T2Aletters}{T2A}{cmr}{m}{it}
\RequirePackage[utf8]{inputenc} % пакет для підтримкм Windows'івського кодування cp1251
\RequirePackage[russian,ukrainian]{babel} % пакет для підтримки української та російської мов
\RequirePackage{pscyr} % пакет із гарними кирилічними шрифтами
\RequirePackage{mathtext} % потрібні символи в режимі математичних формул
\RequirePackage{amssymb,amsfonts,amsmath,amsthm} % потрібні символи в режимі математичних формул
\RequirePackage{textcomp} % потрібні символи в режимі математичних формул
\RequirePackage{upgreek} % пакет для прямих грецьких літер

% графічні пакети
\RequirePackage{graphicx} % основний пакет для вставки графіки
\RequirePackage{subfig} % пакет для вставки підрисунків
\RequirePackage{flafter} % пакет гарантує, що рисунок чи таблица ніколи не з'являться раніше посилання на саму себе
\RequirePackage{caption} % пакет для персоналізації заголовків рисунків та таблиць
\RequirePackage{xtab} % пакет для довгих таблиць
\RequirePackage{multirow} % пакет для об'єднання рядків таблиці

% пакети для форматування відступів та полів
\RequirePackage[top=2cm, bottom=2cm, left=3cm, right=2cm]{geometry} % задаємо поля сторінки
\RequirePackage{indentfirst} % відступ для першого рядка абзацу
\RequirePackage{hanging} % відступ для всіх інших рядків абзацу
\RequirePackage{enumitem}  % пакет для форматування списків
\RequirePackage{setspace}  % пакет для того, щоб можна було задати міжрядковий інтервал
\RequirePackage{fancyhdr} % пакет потрібний для виставлення позиції номеру сторінки
\RequirePackage{etoolbox} % пакет для прибирання висячого відступу в бібліографії

% стилі заголовків та змісту
\RequirePackage[rm,small,raggedright]{titlesec} % пакет для ручного керування стилем заголовків
\RequirePackage[titles,subfigure]{tocloft} % пакет для ручного керування стилем змісту

% пакет для коректного представлення інтернет-посилань у "Джерелах"
\RequirePackage{url}

% пакет для нормальних пробілів після ком у десяткових дробах
\RequirePackage{icomma}

% для нонбрейкінг спейс
\RequirePackage{verbatim}

% текст гіперпосилань буде того ж шрифту, що й основний текст
\urlstyle{same}

% 4. Основна частина
\linespread{1.5} % інтервал "1,5"
\renewcommand{\rmdefault}{ftm} % задаємо шрифт за промовчанням --- "Times New Roman" із пакету pscyr
\renewcommand{\sfdefault}{ftx}
\renewcommand{\ttdefault}{cmtt}

\newcommand{\setfontsize}[1]{\fontsize{#1pt}{#1pt}\selectfont} % команда для задавання розміру шрифта
\newcommand{\invcommas}[1]{\guillemotleft #1\guillemotright} % команда для французьких кутових лапок

% стиль сторінки для позиції номеру сторінки
\fancypagestyle{plain}{
    \fancyhf{}
    \rfoot{\thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

% команди для заборони розриву формул у небажаному місці
\binoppenalty=10000
\relpenalty=10000

% команда для створення ненумерованого розділу, який тим не менше показується в змісті
\newcommand{\uchapter}[1]{\chapter*{#1}\addcontentsline{toc}{chapter}{#1}}

% для створення вступу використаємо команду \uchapter
\newcommand{\intro}{\uchapter{Вступ}}

% для створення висновків використаємо команду \uchapter
\newcommand{\conclusion}{\uchapter{Висновки}}

% для створення перелік умовних позначень використаємо команду \shortings
\newcommand{\shortings}{\uchapter{Перелік умовних позначень, скорочень і термінів}}

% хитра команда для створення додатків
\newcommand{\append}[2]{
  \titleformat{\chapter}[frame]{\centering\normalsize}{\hspace{1cm}\thechapter}{0.5em}{}
\titlespacing{\chapter}{0pt}{0pt}{0pt}
\chapter*{Додаток #1}
\begin{center}
#2
\end{center}
\addcontentsline{toc}{chapter}{Додаток #1 #2}
\titlespacing{\chapter}{0pt}{0pt}{49pt}
\titleformat{\chapter}[frame]{\centering\normalsize\MakeUppercase}{\hspace{1cm}\thechapter}{0.5em}{}
}

% будемо змінювати стилі заголовків
% спочатку --- для розділу
\titleformat{\chapter}[hang] % указуємо, що модифікуємо саме розділ
      {\centering\bfseries\MakeUppercase} % указуємо формат назви (жирний, "усі великі")
      {\hspace{1cm}\thechapter} % указуємо формат власне номера: це буде просто число, без крапки
      {0.5em} % відстань між номером і назвою
      {} % текст, що передує назві

% тепер --- для підрозділу
\titleformat{\section} % указуємо, що модифікуємо саме підрозділ
      {\bfseries\normalsize} % указуємо формат назви (жирний)
      {\thesection} % указуємо формат власне номера: це буде просто число, без крапки
      {0.5em} % відстань між номером і назвою
      {} % текст, що передує назві

% тепер --- для підрозділу ще нижчого рівня
\titleformat{\subsection} % указуємо, що модифікуємо саме підрозділ нижнього рівня
      {\bfseries\normalsize} % указуємо формат назви (жирний)
      {\thesubsection} % указуємо формат власне номера: це буде просто число, без крапки
      {0.5em} % відстань між номером і назвою
      {} % текст, що передує назві

% тепер задамо відступи для заголовку розділу
\titlespacing{\chapter} % указуємо, що модифікуємо саме розділ
      {0pt} % відступ зліва
      {0pt} % відступ зверху (немає)
      {49pt} % відступ знизу (2 рядки)

% тепер задамо відступи для заголовку підрозділу
\titlespacing{\section} % указуємо, що модифікуємо саме підрозділ
      {\parindent} % відступ зліва
      {49pt} % відступ зверху (2 рядки)
      {49pt} % відступ знизу (2 рядки)

% тепер задамо відступи для заголовку підрозділу ще нижчого рівня
\titlespacing{\subsection} % указуємо, що модифікуємо саме підрозділ нижнього рівня
      {\parindent} % відступ зліва
      {49pt} % відступ зверху (2 рядки)
      {49pt} % відступ знизу (2 рядки)

% видозмінюємо зміст
\makeatletter
\renewcommand{\tableofcontents}{%
  \pagestyle{empty}

  \begin{center}
    Зміст
  \end{center}

  \@starttoc{toc}
}
\makeatother

% підганяємо висоту рядка в таблиці
\renewcommand{\arraystretch}{1.2}

% змінюємо формат нумерації формул
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

% нові демаркатори для списків
\renewcommand{\theenumi}{\arabic{enumi})}
\renewcommand{\theenumii}{\arabic{enumii})}
\renewcommand\labelenumi{\theenumi}
\renewcommand\labelenumii{\theenumii}

% задамо оновлені списки, з правильними відступами
% нумерований першого рівня
\newcounter{No}
\renewenvironment{enumerate}[1][\asbuk{No})]
   {\begin{list}{#1}{
       \setlength\partopsep{0pt}
      \setlength\parskip{0pt}
      \setlength\parsep{0pt}
      \setlength\topsep{0pt}
      \setlength\itemsep{0pt}
      \setlength{\itemindent}{1.9cm}
      \setlength{\leftmargin}{0pt}
      \usecounter{No}
    }
  }
  {\end{list}}

% ненумерований першого рівня
\renewenvironment{itemize}[1][{-}]
  {\begin{list}{#1}{
    \setlength\partopsep{0pt}
    \setlength\parskip{0pt}
    \setlength\parsep{0pt}
    \setlength\topsep{0pt}
    \setlength\itemsep{0pt}
    \setlength{\itemindent}{1.7cm}
    \setlength{\leftmargin}{0pt}
    }
  }
  {\end{list}}

% нумерований другого рівня
\newcounter{NoEnum2}
\newenvironment{enumerate2}[1][\arabic{NoEnum2})]
   {\begin{list}{#1}{
       \setlength\partopsep{0pt}
      \setlength\parskip{0pt}
      \setlength\parsep{0pt}
      \setlength\topsep{0pt}
      \setlength\itemsep{0pt}
      \setlength{\itemindent}{2.6cm}
      \setlength{\leftmargin}{0pt}
      \usecounter{NoEnum2}
    }
  }
  {\end{list}}

% мерований другого рівня
\newcounter{NoItem2}
\newenvironment{itemize2}[1][\arabic{NoItem2})]
   {\begin{list}{#1}{
       \setlength\partopsep{0pt}
      \setlength\parskip{0pt}
      \setlength\parsep{0pt}
      \setlength\topsep{0pt}
      \setlength\itemsep{0pt}
      \setlength{\itemindent}{2.35cm}
      \setlength{\leftmargin}{0pt}
      \usecounter{NoItem2}
    }
  }
  {\end{list}}

% тепер займемося змістом
% задаємо відстань між точками
\renewcommand{\cftchapdotsep}{1}
\renewcommand{\cftsecdotsep}{1}
\renewcommand{\cftsubsecdotsep}{1}

% задаємо розмір поля, що виділяється під номер сторінки
\cftsetpnumwidth{1em}

% задамо відстані між рядками в змісті
\setlength\cftbeforechapskip{0pt}

\RequirePackage[pdftex]{xcolor}
% займемося розділами
% \makeatletter
% \patchcmd\@chapter{\numberline{\thechapter.}}{\numberline{\thechapter}}{}{}
% \makeatother
\renewcommand{\cftchapaftersnum}{} % що буде писатися після номеру розділу (нічого)
\renewcommand{\cftchapindent}{0cm} % відступ номера розділу від лівого краю
\renewcommand{\cftchapnumwidth}{1em} % розмір поля, що виділяється під номер розділу
\renewcommand{\cftchappagefont}{\mdseries} % стиль номеру сторінки (звичайний, 14pt)
\renewcommand{\cftchapfont}{\mdseries} % стиль заголовку (звичайний)
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}} % чим заповнювати проміжок від заголовку до номеру сторінки (точками)

% тепер займемося підрозділами
\renewcommand{\cftsecaftersnum}{} % що буде писатися після номеру підрозділу (нічого)
\renewcommand{\cftsecindent}{1em} % відступ номера підрозділу від лівого краю
\renewcommand{\cftsecnumwidth}{2em} % розмір поля, що виділяється під номер підрозділу
\renewcommand{\cftsecpagefont}{\mdseries} % стиль номеру сторінки (звичайний, 14pt)
\renewcommand{\cftsecfont}{\mdseries} % стиль заголовку (звичайний)
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}} % чим заповнювати проміжок від заголовку до номеру сторінки (точками)

% тепер займемося підрозділами ще нижчого рівня
\renewcommand{\cftsubsecaftersnum}{} % що буде писатися після номеру підрозділу нижнього рівня (нічого)
\renewcommand{\cftsubsecindent}{3em} % відступ номера підрозділу нижнього рівня від лівого краю
\renewcommand{\cftsubsecnumwidth}{2.5em} % розмір поля, що виділяється під номер підрозділу нижнього рівня
\renewcommand{\cftsubsecpagefont}{\mdseries} % стиль номеру сторінки (звичайний, 14pt)
\renewcommand{\cftsubsecfont}{\mdseries} % стиль заголовку (звичайний)
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsubsecdotsep}} % чим заповнювати проміжок від заголовку до номеру сторінки (точками)

% заголовки таблиць і рисунків
\DeclareCaptionLabelFormat{tablecap}{Таблиця #2} % формат за промовчанням "Табл." не влаштовує
\DeclareCaptionLabelFormat{figurecap}{Рисунок #2} % формат за промовчанням "Рис." не влаштовує
\DeclareCaptionLabelSeparator{dash}{~--~} % рисунки й таблиці треба відділяти тире, а не крапкою

\captionsetup[table]{singlelinecheck=false, justification=raggedright, labelsep=dash, labelformat=tablecap, font = {stretch = 1.5}} % формат для таблиць
\captionsetup[figure]{justification=centering, labelsep=dash, labelformat=figurecap, font = {stretch = 1.5}} % формат для рисунків

% команда, що змінює латинські літери на кирилічні в підрисунках
\renewcommand{\thesubfigure}{\asbuk{subfigure}}

% нове оточення для довгих таблиць
\newenvironment{xtable}[5]{% "перед"
    \xentrystretch{0}% щоб таблиця не розривалася надто рано
    \topcaption{#3}% заголовок таблиці
    \tablefirsthead{#5}% перша шапка таблиці
    \tablehead{% шапка на інших сторінках
        \multicolumn{#2}{l}{Продовження таблиці \thetable}\\%
        \multicolumn{#2}{l}{}\\% відступ
        #5% дописуємо шапку таблиці
    }
    \tabletail{\hline}% хвіст таблиці
    \tablelasttail{\hline}% останній хвіст таблиці
    \label{#4}% мітка
    \begin{center} % відкриваємо центрування
    \begin{xtabular}{#1}% почнемо довгу таблицю з відповідним форматом
}
    { % "після"
    \end{xtabular} % закриваємо таблицю
    \end{center} % закриваємо центрування
}

% наведемо порядок із відступами в бібліографії
\patchcmd{\thebibliography}
  {\advance\leftmargin\labelsep}
  {\leftmargin=0pt\itemindent=1.9cm\advance\itemindent\labelsep}
  {}{}

% змінюємо формат номеру для списку джерел (число + крапка)
\makeatletter
\renewcommand{\@biblabel}[1]{#1.}
\makeatother

% оновимо стандартне оточення, оскільки потрібно додати список джерел у зміст
\let\tempbib\thebibliography
\let\tempbibend\endthebibliography
\renewenvironment{thebibliography}{
  \renewcommand{\bibname}{ПЕРЕЛІК ПОСИЛАНЬ}% змінюємо заголовок
  \tempbib{99.}% максимально можливий номер джерела --- 99
  % далі наведемо порядок із відступами
  \setlength\partopsep{0pt}
  \setlength\parskip{0pt}
  \setlength\parsep{0pt}
  \setlength\topsep{0pt}
  \setlength\itemsep{0pt}
  \addcontentsline{toc}{chapter}{Перелік посилань}% додаємо в зміст
  }
  {
  \tempbibend
}

% нова команда для титульного аркушу
\newcommand{\maketitlepage}{
    \setcounter{page}{8} % номер сторінки буде 8

    \tableofcontents % вставляємо зміст
    \clearpage % продовжимо з нової сторінки

    \setlength{\parindent}{1.25cm} % задаємо відступ першого рядка абзацу (5 знаків, або 1,25 см)

    % пропуск рядка до та після формули
    \setlength{\belowdisplayskip}{14pt}
    \setlength{\abovedisplayskip}{14pt}
    \setlength{\belowdisplayshortskip}{14pt}
    \setlength{\abovedisplayshortskip}{14pt}
}
