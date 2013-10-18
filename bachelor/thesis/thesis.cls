% Клас для форматування дипломних робіт.
% ************************ ТАВРОВ Д.Ю. *************************
% ************************* 06.02.11 ***************************
% ************************* 12.06.11 ***************************

% 1. Для початку ідентифікуймо клас
\NeedsTeXFormat{LaTeX2e} % потрібний формат

\ProvidesClass{thesis}% ім'я класу
		[2011/06/12 v1.1 Клас для створення дипломних робіт]% опис класу

% 2. Завантажуємо "батьківський клас"
\LoadClass[a4paper]{report}

% 3. Завантажуємо пакети

% мовні пакети
\RequirePackage{mathtext} % кирилиця в формулах
\RequirePackage[T2A]{fontenc} % пакет для підтримки кирилічних шрифтів
\RequirePackage[utf8]{inputenc} % пакет для підтримки Windows'івського кирилічного кодування cp1251
\RequirePackage[russian,ukrainian]{babel} % пакет для підтримки украинської мови
\RequirePackage{pscyr} % гарні кирилічні шрифти
\usepackage{cite} % \cite може приймати кілька аргументів



% графичні пакети
\RequirePackage{graphicx} % основний пакет для вставки графіки (в основному, .eps-файлов)
\RequirePackage{subfig} % пакет для вставки підрисунків
\RequirePackage{flafter} % рисунок або таблиця ніколи не з'являться до посилання на себе
\RequirePackage{caption} % пакет для кастомізації заголовків рисунків і таблиць
\RequirePackage{xtab} % пакет для довгих таблиць
\RequirePackage{rotating} % пакет для підримки "обертання" графіки
\RequirePackage{lastpage} % пакет для відмінної останньої сторінки

% пакети для форматування відступів і берегів
\RequirePackage[top=2cm, bottom=2cm, left=3cm, right=2cm]{geometry} % задаємо формат сторінки
\RequirePackage{indentfirst} % відступ для першого рядка абзацу
\RequirePackage{hanging} % відступ для всіх інших рядків абзацу
\RequirePackage{enumitem}	% пакет для форматування списків
\RequirePackage{setspace} % інтервал 1,5
\RequirePackage{fancyhdr} % позиція номеру сторінки

\RequirePackage{verbatim} % для нонбрейкінг спейс
\RequirePackage{listings}

\RequirePackage{amssymb} % для спеціальних математичних символів

% пакет для коректного представлення інтернет-посилань у "Джерелах"
\RequirePackage{url}

% прямі грецькі літери
\RequirePackage{upgreek}

% стилі заголовків та змісту
\RequirePackage[rm,bf,small,raggedright]{titlesec} % пакет для ручного керування стилями заголовків
																									 % назви заголовків будум щонайменше вирівняні за лівим краєм
																									 % (усе інше - нижче за текстом)

\RequirePackage[titles,subfigure]{tocloft} % пакет для ручного керування стилем змісту

% 4. Основна частина

% спочатку визначмо команди для розмітки
\renewcommand{\rmdefault}{ftm} % шрифт за замовчуванням

% відступ першого рядка абзацу
\parindent 1cm

% стиль сторінки для позиції номеру сторінки
\pagestyle{fancy}
	\lhead{}
	\chead{}
	\rhead{}
	\lfoot{}
	\cfoot{}
	\rfoot{\thepage}
\renewcommand{\headrulewidth}{0pt}

\newcommand{\setfontsize}[1]{\fontsize{#1pt}{#1pt}\selectfont} % команда для "прискореного" задання розміру шрифта
\newcommand{\invcommas}[1]{\guillemotleft #1\guillemotright} % створюємо нормальні кутові лапки

% видозмінюємо зміст
\renewcommand{\tableofcontents}{%
	\setfontsize{14}

	\begin{center}
	  \textbf{ЗМІСТ}
	\end{center}

	\renewcommand{\baselinestretch}{1.5}
	\@starttoc{toc}
}

\newcommand{\maketitlepage}{
	\setcounter{page}{8} % номер сторінки буде 8

  \thispagestyle{empty}
	\tableofcontents % вставляємо зміст
  \thispagestyle{empty}
	\newpage

	\setfontsize{14} % задаємо нормальний розмір шрифта
}

% теперь змінюватимемо стилі заголовків
% спочатку - для розділу
\titleformat{\chapter} % указуємо, що модифікуємо саме розділ
			{\centering\usefont{T2A}{ftm}{b}{n}\setfontsize{14}} % указуємо формат і номера, і лейбла
			{\thechapter} % указуємо формат самого номера
			{0.5em} % відстань між номером і лейблом
      {} % текст, що передує заголовку розділа

% тепер - для секції
\titleformat{\section} % указуємо, що модифікуємо саме секцію
			{\usefont{T2A}{ftm}{b}{n}\setfontsize{14}} % указуємо формат і номера, і лейбла
			{\thesection} % указуємо формат самого номера
			{0.5em} % відстань між номером і лейблом
			{} % текст, що передує заголовку секції

% тепер - для підсекції
\titleformat{\subsection} % указуємо, що модифікуємо саме підсекцію
			{\usefont{T2A}{ftm}{b}{n}\setfontsize{14}} % указуємо формат і номера, і лейбла
			{\thesubsection} % указуємо формат самого номера
			{0.5em} % відстань між номером і лейблом
			{} % текст, що передує заголовку підсекції

\titleformat{\subsubsection} % указуємо, що модифікуємо саме підсекцію
			{\usefont{T2A}{ftm}{m}{it}\setfontsize{14}} % указуємо формат і номера, і лейбла
			{\thesubsection} % указуємо формат самого номера
			{0.5em} % відстань між номером і лейблом
			{} % текст, що передує заголовку підсекції


% перевизначмо важливу системну команду саме з ціллю можливости задання нормальних параметрів стилю
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
										\thispagestyle{fancy}
                    \renewcommand{\baselinestretch}{1.5}\setfontsize{14}% інтервал і кегль
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}

\newcommand{\uchapter}[1]{\chapter*{#1}\renewcommand{\baselinestretch}{1.5}\setfontsize{14pt}\addcontentsline{toc}{chapter}{#1}} % команда для створення ненумерованого розділу
																																					 % котра тим не менше показується в змісті

% для створення вступу використаймо команду \uchapter
\newcommand{\intro}{\uchapter{ВСТУП} \renewcommand{\baselinestretch}{1.5}}

% для створення списку скорочень також
\newcommand{\shortings}{\uchapter{СПИСОК ТЕРМІНІВ, УМОВНИХ ПОЗНАЧЕНЬ ТА СКОРОЧЕНЬ} \renewcommand{\baselinestretch}{1.5}}

\newcommand{\append}[2]{\section*{ДОДАТОК #1. #2} \renewcommand{\baselinestretch}{1.5}}

% тут перевизначити не вдасться, тому просто робимо нову команду
\newcommand{\Section}[1]{\section{#1} \renewcommand{\baselinestretch}{1.5}\setfontsize{14}}% інтервал і кегль
% тут перевизначити не вдасться, тому просто робимо нову команду
\newcommand{\Subsection}[1]{\subsection{#1} \renewcommand{\baselinestretch}{1.5}\setfontsize{14}}% интервал и кегль

% тепер задамо властивості абзацу
% спочатку - для розділу
\titlespacing{\chapter} % указуємо, що модифікуємо саме розділ
			{2cm} % відступ зліва
			{-20pt} % відступ зверху
			{28pt} % відступ знизу

% тепер - для секції
\titlespacing{\section} % указуємо, що модифікуємо саме секцію
			{1.25cm} % відступ зліва
			{14pt} % відступ зверху
			{14pt} % відступ знизу

% тепер - для підсекції
\titlespacing{\subsection} % указуємо, що модифікуємо саме підсекцію
			{1.25cm} % відступ зліва
			{14pt} % відступ зверху
			{14pt} % відступ знизу

% тепер займемося змістом
% спочатку задамо відстань між точками
\renewcommand{\cftsecdotsep}{1}

% потім - поле, що виділяється під номер сторінки
\cftsetpnumwidth{1em}

% тепер займемося розділами
\renewcommand{\cftchapaftersnum}{.} % що буде писатися після номера розділу
\renewcommand{\cftchapindent}{0mm} % відступ номера розділа від лівого берега
\renewcommand{\cftchapnumwidth}{1em} % загальне поле, що виділяється під номер розділа
\setlength{\cftbeforechapskip}{6pt} % проміжок "до"
\renewcommand{\cftchappagefont}{\mdseries\setfontsize{14}} % стиль номера сторінки
\renewcommand{\cftchapfont}{\mdseries} % стиль заголовка
\renewcommand{\cftchapfont}{\setfontsize{14pt}} % стиль шрифта
\renewcommand{\cftchapleader}{\cftdotfill{\cftsecdotsep}} % чим заповнювати проміжок від заголовка до номера сторінки (точками)

% теперь займемося секціями
\renewcommand{\cftsecaftersnum}{.} % що буде писатися після номера секції
\renewcommand{\cftsecindent}{6mm} % відступ номера розділа від лівого берега
\renewcommand{\cftsecnumwidth}{2em} % загальне поле, що виділяється під номер секції
\setlength{\cftbeforesecskip}{6pt} % проміжок "до"
\renewcommand{\cftsecpagefont}{\mdseries\setfontsize{14}} % стиль номера сторінки
\renewcommand{\cftsecfont}{\setfontsize{14pt}} % стиль шрифта
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}} % чим заповнювати проміжок від заголовка до номера сторінки (точками)

% теперь займёмся підсекціями
\renewcommand{\cftsubsecaftersnum}{.} % що буде писатися після номера підсекції
\renewcommand{\cftsubsecindent}{12mm} % відступ номера розділа від лівого берега
\renewcommand{\cftsubsecnumwidth}{2.5em} % загальне поле, що виділяється під номер підсекції
\setlength{\cftbeforesubsecskip}{6pt} % проміжок "до"
\renewcommand{\cftsubsecpagefont}{\mdseries\setfontsize{14}} % стиль номера сторінки
\renewcommand{\cftsubsecfont}{\setfontsize{14pt}} % стиль шрифта
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsecdotsep}} % чим заповнювати проміжок від заголовка до номера сторінки (точками)

% займемося рисунками і таблицями
\DeclareCaptionLabelFormat{tablecap}{\setfontsize{14}Таблиця #2} % старий формат "Табл." не влаштовував

% заголовки
\captionsetup[table]{justification=raggedleft, font={Large,rm}, textfont=md, labelsep=space} % спочатку для таблиць
\captionsetup[figure]{justification=centering, font={Large,rm}, labelsep=space} % тепер для рисунків

% команда, що змінює латинські літери на кирилічні в підрисунках
\renewcommand{\thesubfigure}{\asbuk{subfigure}}

% тепер створимо оточення для нових таблиць
\newenvironment{supertable}[5]{% "перед"
		\topcaption{\setfontsize{14}#3}% заголовок таблиці
		\tablefirsthead{#5}% перший заголовок таблиці
		\tablehead{% заголовок на інших сторінках
				\multicolumn{#2}{l}{Продовження Табл. \thetable.}\\%
				\multicolumn{#2}{l}{}\\% красивий відступ
				#5% дописуємо старий заголовок
		}
		\tabletail{\hline}% хвіст таблиці
		\tablelasttail{\hline}% останній хвіст таблиці
		\label{#4}% мітка
		\begin{center} % відкриваємо центрування
		\begin{xtabular}{#1}% почнемо довгу таблицю
}
		{ % "після"
		\end{xtabular} % закриваємо таблицю
		\end{center} % закриваємо центрування
}

% займемося бібліографією
% міняємо формат номера
\makeatletter
\renewcommand{\@biblabel}[1]{#1.}
\makeatother

% крім того, треба додати бібліографії в зміст
\newenvironment{references}{
	\renewcommand{\bibname}{СПИСОК ВИКОРИСТАНИХ ЛІТЕРАТУРНИХ ДЖЕРЕЛ}% міняємо заголовок
	\begin{thebibliography}{99.}
	\addcontentsline{toc}{chapter}{СПИСОК ВИКОРИСТАНИХ ЛІТЕРАТУРНИХ ДЖЕРЕЛ}
	}
	{
	\end{thebibliography}
}

% міняємо формат нумерації формул
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

% нові стилі для списків
\renewcommand{\theenumi}{\arabic{enumi})}
\renewcommand{\theenumii}{\arabic{enumii})}
\renewcommand\labelenumi{\theenumi}
\renewcommand\labelenumii{\theenumii}

% задамо нові списки з правильним відступом
\newenvironment{enumerator}{\begin{enumerate}[leftmargin=1.6cm]%
	\setlength{\itemsep}{1pt}% команди, щоб зробити одиничний інтервал у списку
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
  }
{\end{enumerate}}

\newenvironment{itemizer}{\begin{itemize}[leftmargin=1.45cm]%
	\setlength{\itemsep}{1pt}% команди, щоб зробити одиничний інтервал у списку
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
  }
{\end{itemize}}
