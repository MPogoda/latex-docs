% ************ Класс для написания отчётов по лабам ************
% ************************ ТАВРОВ Д.Ю. *************************
% ************************* 22.01.11 ***************************
% *********************Изменения: 15.02.11 *********************
% *********************Изменения: 20.02.11 *********************
% *********************Изменения: 05.01.12 *********************

% 1. Для начала идентифицируем класс
\ProvidesClass{labs}% имя класса
    [2012/05/01 v2.5 Клас для написання звітів до лабораторних робіт із дисципліни
        ``Обчислювальні системи'']% описание класса
				
\NeedsTeXFormat{LaTeX2e} % необходимый формат


% 2. Загружаем "родительский" класс
\LoadClass[a4paper,oneside]{report}
%\LoadClass[a4paper,oneside]{scrreprt}

% 3. Загружаем пакеты
% языковые пакеты
%\RequirePackage{mathtext}
\RequirePackage[russian,ukrainian]{babel} % пакет для поддержки украинского языка
\RequirePackage[T2A]{fontenc} % пакет для поддержки кириллических шрифтов
%\RequirePackage[cp1251]{inputenc} % пакет для поддержки Windows'овской кириллической кодировки cp1251
\RequirePackage[utf8]{inputenc}
\RequirePackage{pscyr} % красивые кириллические шрифты
\RequirePackage{textcomp}

% графические пакеты
\RequirePackage{graphicx} % основной пакет для вставки графики (в основном, .eps-файлов)
\RequirePackage{subfig} % пакет для вставки подрисунков
\RequirePackage{flafter} % рисунок или таблица никогда не появится до ссылки на себя
\RequirePackage{caption} % пакет для кастомизации заголовков рисунков и таблиц
\RequirePackage{xtab} % пакет для длинных таблиц
%\RequirePackage{upgreek} % пакет для прямых греческих букв

% пакеты для форматирования отступов и полей
%\RequirePackage{a4wide}
\RequirePackage[top=1.5cm, bottom=1.5cm, left=2.5cm, right=1.5cm]{geometry} % задаём формат страницы
\RequirePackage{indentfirst} % отступ для первой строки абзаца
\RequirePackage{hanging} % отступ для всех других строк абзаца
\RequirePackage{enumitem}	% пакет для форматирования списков
\RequirePackage{setspace}	% полуторный интервал

% стили заголовков и оглавления
\RequirePackage[rm,bf,small,raggedright]{titlesec} % пакет для ручного управления стилем заголовков; 
																									 % названия заголовков будум как минимум выровнены по левому краю
																									 % (всё остальное - ниже по тексту)

\RequirePackage[titles,subfigure]{tocloft} % пакет для ручного управления стилем оглавления

% пакет для корректного представления интернет-ссылок в "Джерелах"
\RequirePackage{url}

% пакет для нормальных пробелов после запятых в десятичных дробях
\RequirePackage{icomma}


% 4. Основная часть
% сначала определим команды для разметки
\renewcommand{\rmdefault}{ftm} % задаём шрифт по умолчанию

\newcommand{\setfontsize}[1]{\fontsize{#1pt}{#1pt}\selectfont} % команда для "ускоренного" задания размера шрифта
\newcommand{\invcommas}[1]{\guillemotleft #1\guillemotright} % создаём нормальные угловые кавычки
\setlength{\parindent}{1cm} % задаём отступ первой строки абзаца

% команды для запрета разрыва формул в нежелательном месте
\binoppenalty=10000
\relpenalty=10000

% переопределяем команду объявления новой главы, чтобы корректно было с полуторным интервалом
\newcommand{\Chapter}[1]{\chapter{#1} \renewcommand{\baselinestretch}{1.5}\setfontsize{14pt}}

\newcommand{\uchapter}[1]{\chapter*{#1}\renewcommand{\baselinestretch}{1.5}\setfontsize{14pt}\addcontentsline{toc}{chapter}{#1}} % команда для создания ненумерованной главы,
																																					 % которая тем не менее показывается в оглавлении
																																					 % данная команда написана "на вырост", реально не 	
																																					 % используется

% для создания вступления воспользуемся командой \uchapter
\newcommand{\intro}{\uchapter{ВСТУП} \renewcommand{\baselinestretch}{1.5}}

% видоизменяем содержание
\makeatletter
\renewcommand{\tableofcontents}{%
	\begin{center}
	  \textbf{ЗМІСТ}
	\end{center}
	
	\addvspace{10pt}
	\begin{flushright}
		стор.			    
	\end{flushright}
	
	\addvspace{-15pt}
	
	\@starttoc{toc}
}
\makeatother

% чтобы красивые были ячейки в таблице по высоте
\renewcommand{\arraystretch}{1.2}

% меняем формат нумерации формул
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

% новые стили для списков
% эти команды нужны для корректного отображения списков
%\renewcommand{\theenumi}{\arabic{enumi})}
%\renewcommand{\theenumii}{\arabic{enumii})}
%\renewcommand\labelenumi{\theenumi}
%\renewcommand\labelenumii{\theenumii}

% зададим новые списки, с правильным отступом
\newenvironment{enumerator}{\begin{enumerate}[leftmargin=1.6cm]%
  \setlength{\itemsep}{1pt}% команды, чтобы сделать единичный интервал в списке
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
  }{\end{enumerate}}
\newenvironment{itemizer}{\begin{itemize}[leftmargin=1.45cm]%
  \setlength{\itemsep}{1pt}% команды, чтобы сделать единичный интервал в списке
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
  }{\end{itemize}}											


% специальные команды для определения длины отступа в заголовке для додатков
\newlength{\appendlength} % задаём новую единицу длины
\settowidth{\appendlength}{\hspace{1cm}\textbf{\textsc{\setfontsize{16}Додаток 1.\ }}} % отступ для Додатку

\newlength{\subappendlength} % задаём новую единицу длины
\settowidth{\subappendlength}{\hspace{1cm}\textbf{\textit{\setfontsize{14}Додаток 1.1.\ }}} % отступ для под-Додатку

% чуть больше потребуется повозиться с "Додатками"
\newcounter{append} % новый счётчик для Додатку
\setcounter{append}{0} % устанавливаем его в 0

\newcounter{subappend} % новый счётчик для секции в Додатку
\setcounter{subappend}{0} % устанавливаем его в 0

\renewcommand{\theappend}{Додаток \arabic{append}}
\renewcommand{\thesubappend}{\theappend.\arabic{subappend}} % счётчик под-Додатка должен включать счётчик Додатка

\newcommand{\append}[1]% переопределяем команды накручивания счётчиков для выведения заголовков нужного формата (см. ниже)
	{\refstepcounter{append}% накручиваем счётчик
		{\clearpage% с новой страницы
		\bfseries\setfontsize{14pt}% наш шрифт
		\begin{hangparas}{\appendlength}{1}\hspace{1cm}\theappend. #1\end{hangparas}% сам заголовок
		\vspace{24pt}% отступ
		\addcontentsline{toc}{chapter}{\theappend. #1}% и наконец вставляем в оглавление
	}
} 

\newcommand{\subappend}[1]% переопределяем команды накручивания счётчиков для выведения заголовков нужного формата (см. ниже)
	{\refstepcounter{subappend}% накручиваем счётчик
		{\addvspace{12pt}% отступ
		\begin{hangparas}{\subappendlength}{1}\textbf{\textit{\setfontsize{14pt}% наш шрифт и начало абзаца с отступами
		\hspace{1cm}\thesubappend. #1}}\end{hangparas}% сам заголовок
		\vspace{12pt}% отступ
		\addcontentsline{toc}{section}{\thesubappend. #1}% и наконец вставляем в оглавление
	}
}

% теперь будем изменять стили заголовков
% сначала - для главы
\titleformat{\chapter} % указываем, что модифицируем именно главу
			{\centering\usefont{T2A}{ftm}{b}{n}\setfontsize{14pt}} % указываем формат и номера, и лейбла (жирный "все заглавные")
			{\hspace{1cm}\thechapter.} % указываем формат самого номера: число + .
			{0.5em} % расстояние между номером и лейблом
			{} % текст, предшествующий заголовку главы
	
% теперь - для секции
\titleformat{\section} % указываем, что модифицируем именно секцию
			{\usefont{T2A}{ftm}{b}{n}\setfontsize{14pt}} % указываем формат и номера, и лейбла (жирный)
			{\thesection.} % указываем формат самого номера: число + .
			{0.5em} % расстояние между номером и лейблом
			{} % текст, предшествующий заголовку секции

% теперь - для секции
\titleformat{\subsection} % указываем, что модифицируем именно секцию
			{\usefont{T2A}{ftm}{b}{n}\setfontsize{12pt}} % указываем формат и номера, и лейбла (жирный)
			{\thesubsection.} % указываем формат самого номера: число + .
			{0.5em} % расстояние между номером и лейблом
			{} % текст, предшествующий заголовку секции
			
% теперь зададим свойства абзаца
% сначала - для главы
\titlespacing{\chapter} % указываем, что модифицируем именно главу
			{2cm} % отступ слева
			{12pt} % отступ сверху
			{12pt} % отступ снизу

% теперь - для секции
\titlespacing{\section} % указываем, что модифицируем именно секцию
			{1.25cm} % отступ слева
			{6pt} % отступ сверху
			{6pt} % отступ снизу
			
% теперь - для подсекции
\titlespacing{\subsection} % указываем, что модифицируем именно подсекцию
			{1.25cm} % отступ слева
			{6pt} % отступ сверху
			{6pt} % отступ снизу
			
% переопределяем команду объявления новой секции, чтобы корректно было с полуторным интервалом
\newcommand{\Section}[1]{\section{#1} \renewcommand{\baselinestretch}{1.5}\setfontsize{14pt}}

% переопределяем команду объявления новой подсекции, чтобы корректно было с полуторным интервалом
\newcommand{\Subsection}[1]{\subsection{#1} \renewcommand{\baselinestretch}{1.5}\setfontsize{14pt}}		
			
% теперь займёмся оглавлением
% сначала задаём расстояние между точками
\renewcommand{\cftchapdotsep}{1}
\renewcommand{\cftsecdotsep}{1}
\renewcommand{\cftsubsecdotsep}{1}

% затем - поле, выделяемое под номер страницы
\cftsetpnumwidth{1em}

% теперь займёмся главами
\renewcommand{\cftchapaftersnum}{.} % что будет писаться после номера главы
\renewcommand{\cftchapindent}{1cm} % отступ номера главы от левого края
\renewcommand{\cftchapnumwidth}{1em} % общее поле, выделяемое под номер главы
\setlength{\cftbeforechapskip}{6pt} % промежуток "до"
\renewcommand{\cftchappagefont}{\mdseries\setfontsize{14pt}} % стиль номера страницы
\renewcommand{\cftchapfont}{\mdseries} % стиль заголовка
\renewcommand{\cftchapfont}{\setfontsize{14pt}} % стиль шрифта ("все заглавные")
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}} % чем заполнять промежуток от заголовка до номера страницы (точками)

% теперь займёмся секциями
\renewcommand{\cftsecaftersnum}{.} % что будет писаться после номера секции
\renewcommand{\cftsecindent}{1.5cm} % отступ номера секции от левого края
\renewcommand{\cftsecnumwidth}{2em} % общее поле, выделяемое под номер секции
\setlength{\cftbeforesecskip}{6pt} % промежуток "до"
\renewcommand{\cftsecpagefont}{\mdseries\setfontsize{14pt}} % стиль номера страницы
\renewcommand{\cftsecfont}{\setfontsize{14pt}} % стиль шрифта
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}} % чем заполнять промежуток от заголовка до номера страницы (точками)

% теперь займёмся подсекциями
\renewcommand{\cftsubsecaftersnum}{.} % что будет писаться после номера секции
\renewcommand{\cftsubsecindent}{2cm} % отступ номера секции от левого края
\renewcommand{\cftsubsecnumwidth}{2.5em} % общее поле, выделяемое под номер секции
\setlength{\cftbeforesubsecskip}{6pt} % промежуток "до"
\renewcommand{\cftsubsecpagefont}{\mdseries\setfontsize{14pt}} % стиль номера страницы
\renewcommand{\cftsubsecfont}{\setfontsize{14pt}} % стиль шрифта
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsubsecdotsep}} % чем заполнять промежуток от заголовка до номера страницы (точками)					

% заголовки таблиц и рисунков
\DeclareCaptionLabelFormat{tablecap}{Таблиця #2} % старый формат "Табл." не устраивал 
\captionsetup[table]{justification=raggedleft, font={Large,rm}, textfont=md, labelsep=period, labelformat=tablecap} % сначада для таблиц
\captionsetup[figure]{justification=centering, font={Large,rm}, labelsep=period} % теперь для рисунков

% команда, изменяющая латинские буквы на привычные кириллические в подрисунках
\renewcommand{\thesubfigure}{\asbuk{subfigure}}

% теперь создадим новое окружение, сразу объединяющее в себе таблицы и "длинные" таблицы
\newenvironment{supertable}[5]{% "перед"
		\topcaption{#3}% заголовок таблицы
		\tablefirsthead{#5}% первый заголовок таблицы
		\tablehead{% заголовок на других страницах
				\multicolumn{#2}{l}{Продовження Табл. \thetable.}\\%
				\multicolumn{#2}{l}{}\\% красивый отступ
				#5% дописываем старый заголовок
		}
		\tabletail{\hline}% хвост таблицы
		\tablelasttail{\hline}% последний хвост таблицы
		\label{#4}% метка
		\begin{center} % открываем центрирование
		\begin{xtabular}{#1}% начнём длинную таблицу с соответствующим параметром		
}
		{ % "после"
		\end{xtabular} % закрываем таблицу
		\end{center} % закрываем центрирование
}

% займёмся библиографией
% меняем формат номера
\makeatletter
\renewcommand{\@biblabel}[1]{#1.}
\makeatother

% кроме того, надо добавить библиографию в оглавление
\newenvironment{references}{
	\renewcommand{\bibname}{СПИСОК ВИКОРИСТАНОЇ ЛІТЕРАТУРИ}% меняем заголовок, показываемый при ссылках
	\begin{thebibliography}{99.}
	\addcontentsline{toc}{chapter}{СПИСОК ВИКОРИСТАНОЇ ЛІТЕРАТУРИ}
	}
	{
	\end{thebibliography}
}

% титульный лист
\newcommand{\maketitlepage}[4]{ % будет 4 аргумента: номер лабораторки, название, выполнивший (ФИО), группа
	  \thispagestyle{empty} % эта команда необходима, чтобы не генерировать номер на титуле	  
		\setfontsize{16}% задаём размер шрифта для Министерства
		\begin{center} % "по центру"
			\MakeUppercase{Міністерство освіти і науки,}
			
			\MakeUppercase{молоді та спорту України} % идёт текст (причём заглавными буквами)
			
			\MakeUppercase{Національний технічний університет України}
			
			\MakeUppercase{\invcommas{Київський політехнічний інститут}}
			
			\addvspace{6pt} % небольшой отступ
			
			\setfontsize{14}
			Кафедра прикладної математики
		
			\vfill % заполняем промежуток автоматически
			
			\setfontsize{16} % устанавливаем новый размер шрифта для названия документа
			
			\MakeUppercase{#2} %заголовок
			
			\addvspace{6pt} % небольшой отступ
			
			\setfontsize{14} % устанавливаем обычный размер шрифта
			
			{Звіт із лабораторної роботи \textnumero#1}
			
			\addvspace{6pt} % небольшой отступ
			
			із дисципліни:
			
			\addvspace{6pt} % небольшой отступ
			
			\invcommas{Обчислювальні системи}
		\end{center}
		
		\vfill % заполняем промежуток автоматически
		
		\setlength{\parindent}{0cm} % временно без индентации
			Виконав: \MakeUppercase{#3} \hfill Керівник:
			
			Група: #4 \hfill ТАВРОВ Д.Ю.
		
		\setlength{\parindent}{1cm} % восстанавливаем индентацию
		
		\vfill % заполняем промежуток автоматически
		
		\begin{center} % а дата - по центру
			КИЇВ
			
			2012
		\end{center}
		
		\clearpage % начинаем с новой страницы
		\setcounter{page}{2} % номер страницы будет 2, а не 1, как по умолчанию
		
		\tableofcontents % вставляем оглавление
		\clearpage % начнём первую главу с новой страницы
		
		\setfontsize{14} % задаём нормальный размер шрифта
}																														 
