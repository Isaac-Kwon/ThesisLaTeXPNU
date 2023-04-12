%%
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pnuthesis}
              [2021/09/05 PNU PHYS document class]

% \documentclass에 대한 옵션 필드 설정
% Usage: \documentclass[degree]{class_file_name}
% degree는 두 가지 선택가능 master, doctor
\newif\if@Doctor
\DeclareOption{doctor} {\@Doctortrue}
\DeclareOption{master} {\@Doctorfalse}

% korean... 설정 된 경우 국문 논문임.
\newif\if@Korean
\DeclareOption{korean} {\@Koreantrue}
\DeclareOption{english} {\@Koreanfalse}

\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor}
\ProcessOptions

% base class: report class 사용
% report class에 대한 설명은 latex 관련 book에서 참고가능
\LoadClass[11pt,a4paper,onecolumn,oneside]{report}
% \LoadClass[11pt,a4paper,onecolumn, twoside]{report}
% \usepackage{showframe}

\usepackage{tikz}

\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{ifthen}
\usepackage{times}
\usepackage{chngpage}
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage{xspace}
\usepackage{mathtools}
\usepackage{enumitem}
\usepackage{caption}
\usepackage{lscape}
\usepackage{lastpage}
\usepackage{tocloft}
\usepackage{listings}
\usepackage{setspace}

\pagenumbering{arabic}
% \rfoot{Page \thepage \hspace{1pt} of \pageref{LastPage}}


\if @Korean
	\usepackage{tocloft}
	\usepackage[hangul]{kotex}
\else
	\usepackage{kotex}
\fi


% \setlength{\paperwidth}  {210mm}
% \setlength{\paperheight} {297mm}

% 페이지여백 설정
\addtolength{\hoffset}  {-1 in}
\addtolength{\voffset}  {-1 in}

\addtolength{\hoffset}  {25 mm}
\addtolength{\voffset}  {35 mm}

\setlength{\topmargin}  {0mm}
\setlength{\headheight} {0mm}
\setlength{\headsep}    {0mm}

\setlength{\marginparwidth} {10mm}
\setlength{\marginparsep}   {0mm}

\setlength{\textwidth}      {150mm}
\setlength{\textheight}     {227mm}
\setlength{\oddsidemargin}  {5mm}
\setlength{\footskip}       {17.5mm}

\if@Korean
	\setlength{\textheight} {227mm}
	\setlength{\footskip}   {17.5mm}
\fi

% \title 명령어 재설정
% 한글, 영어 두 종류의 타이틀을 모두 넣는다.
% Usage: \title[korean]{Korean_Title}
% Usage: \title[english]{English_Title}

% renew related strings if Korean.

\if@Korean
\renewcommand{\contentsname}{목~~차\hfill}
\renewcommand{\listfigurename}{그림 목록}
\renewcommand{\listtablename}{표 목록}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\bibname}{참고 문헌}
\renewcommand{\figurename}{그림}
\renewcommand{\tablename}{표}
\else
\renewcommand{\contentsname}{Contents}
\renewcommand{\bibname}{References}
\renewcommand{\figurename}{Figure}
\renewcommand{\tablename}{Table}
\fi

\renewcommand{\title}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorTitle}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngTitle}{#2}}{}%
}
\@onlypreamble{\title}

% 저자 정보
\renewcommand{\author}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AuthorNS}{#2}}{}%
}
\@onlypreamble{\author}

% 지도교수 정보
\newcommand{\adviser}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAdviser}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAdviser}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AdviserNS}{#2}}{}%
}
\@onlypreamble{\adviser}

% 논문 심사일
\newcommand{\examinationdate}[2][korean]{%
	\ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorExamYear}{#2}}{}%
	\ifthenelse{\equal{#1}{english}}{\newcommand{\@EngExamYear}{#2}}{}%
}
\@onlypreamble{\examinationdate}

% 졸업년월
\newcommand{\gradyear}[2][korean]{%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@GradYearEng}{#2}}{}%
    \ifthenelse{\equal{#1}{korean} }{\newcommand{\@GradYearKor}{#2}}{}%
}
\@onlypreamble{\gradyear}

% 초록
\newcommand{\abstracts}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAbstract}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAbstract}{#2}}{}%%
}
\@onlypreamble{\abstracts}

\newcommand{\pushAbstract}[1][english]{%
    \ifthenelse{\equal{#1}{korean}}{
		\begin{abstractKOR}
			\setstretch{1.3}
			\@KorAbstract
		\end{abstractKOR}
	}{}%
    \ifthenelse{\equal{#1}{english}}{		
		\begin{abstractENG}
			\setstretch{1.3}
			\@EngAbstract
		\end{abstractENG}
	}{}%%
}

\AtBeginDocument{%
	\pagenumbering{gobble}
    \makecover%
    \makeapproval%
	\pagenumbering{arabic}
    }
\AtEndDocument{
	\pagebreak
	\if@Korean
	\pushAbstract[english]
	\else
	\pushAbstract[korean]
	\fi
	\pagenumbering{gobble}
}

\renewcommand\appendix{
	\clearpage
	\if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
	\if@Korean
	% \chapter*{부록}
	\begin{center}
		\Huge\textbf{부~~록}
	\end{center}
	\addcontentsline{toc}{chapter}{부록}
	\else
	\begin{center}
    \Huge\textbf{Appendix}
	\end{center}
	\addcontentsline{toc}{chapter}{Appendix}
	\fi
	\renewcommand{\thechapter}{\Alph{chapter}}%
	\setcounter{chapter}{0}
	\setcounter{section}{0}
	\setcounter{subsection}{0}
	\let\clearpage\relax 

}

% 외표지 작성
\newcommand{\makecover}{%
            \thispagestyle{empty}
            %\changetext{}{10mm}{-5mm}{}{}
%           \noindent
            \begin{center}
				\vspace*{0.5cm}
				\vspace*{2pt}
                % \Large
				\fontsize{16pt}{16pt}
				\selectfont
				\if@Korean
					\if@Doctor
						박 사 학 위 논 문 \\
					\else
						석 사 학 위 논 문 \\
					\fi
				\else
					\if@Doctor
						Dissertation for the degree of Doctor of Philosophy  \\
					\else
						Thesis for the degree of Master of Science\\
					\fi
				\fi
                \vspace*{2cm}
				\vspace*{-12pt}
				{ 
					% \begin{spacing}{1.0}
					\setstretch{1.3}
					\fontsize {22pt}{24pt}
					\selectfont
					\if@Korean
						\@KorTitle\ \\
					\else
						\@EngTitle\ \\
					\fi
					% \end{spacing}
				}


            \vfill
            \end{center}
                \begin{minipage}[t][60mm][b]{\textwidth} % 바닥 기준 정렬 시작
                    \begin{center}
                    \fontsize{16pt}{18pt}
					\selectfont
					\if@Korean
					\@KorAuthor
					\else
					\@EngAuthor
					\fi
					\\
					\vspace*{2cm}
					\if@Korean
						{
							\fontsize {16pt}{18pt}
							\selectfont
							부산대학교 대학원\\
						}
						\vspace*{0.5cm}
						\vspace*{-0.18cm}
						{
							\fontsize {16pt}{18pt}
							\selectfont
							물리학과 \\
						}
					\else
						Department of Physics \\
						The Graduate School \\
						Pusan National University \\
					\fi
					\vspace*{2cm}
					\fontsize{16pt}{0pt}
					\selectfont
					\if@Korean
						\textbf{\@GradYearKor} \\
					\else
						\textbf{\@GradYearEng} \\
					\fi
					\vspace*{0.5cm}
                    \end{center}
                \end{minipage}
            \newpage
            }

\newcommand{\makeapproval}{%
            \thispagestyle{empty}
            \begin{center}
				\vspace*{0.00cm}
				\setstretch{1.3}
                % 타이틀 시작
				\fontsize{22pt}{24pt}
				\selectfont
				\if@Korean
					\@KorTitle\ \\
				\else
					\@EngTitle\ \\
				\fi
                \vspace*{1.5cm}
				\vspace*{-9pt}
				
				\if@Korean % 1차 본문 시작 (한국어)
					\fontsize {16pt}{16pt}
					\selectfont
					\if@Doctor
						이 논문을 이학박사 학위논문으로 제출함\\
					\else
						이 논문을 이학석사 학위논문으로 제출함\\
					\fi
					\vspace*{1.5cm}
					\fontsize {14pt}{16pt}
					\selectfont
					\@KorAuthor \\ 
					\vspace*{1.0cm}
					부산대학교 대학원 \\ 
					\vspace*{0.5cm}
					물 리 학 과 \\
					\vspace*{1.0cm}
					지 도 교 수 ~\@KorAdviser \\
				\else % 1차 본문 시작 (영어)
					\setstretch{1.3}
					\fontsize {14pt}{16pt}
					\selectfont
					\if@Doctor
					A Dissertation submitted to the graduate school of Pusan National University in partial fulfillment of the requirements for the degree of Doctor of Philosophy in Physics \\ under the direction of \textbf{\@EngAdviser}
					\else
					A Thesis submitted to the graduate school of Pusan National University in partial fulfillment of the requirements for the degree of Master of Physics \\ under the direction of \textbf{\@EngAdviser}
					\fi
				\fi


            \vfill
            \end{center}
                \begin{minipage}[t][60mm][b]{\textwidth} % 바닥 기준 정렬 시작
                    \begin{center}
						\if@Korean % 2차 본문 시작 (한국어)
						\fontsize {16pt}{18pt}
						\selectfont
						\if@Doctor
							\@AuthorNS의 이학박사 학위논문을 인준함\\
						\else
							\@AuthorNS의 이학석사 학위논문을 인준함\\
						\fi
						\vspace*{1.0cm}
						\fontsize {14pt}{16pt}
						\selectfont
						\textbf{\@KorExamYear}\ \\
						\vspace*{1.0cm}
						\vspace*{-20pt}
						\setstretch{2.0}
						\fontsize {14pt}{16pt}
						\selectfont
						위~~원~~장:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}인\\
						위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}인\\
						위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}인\\
						\if@Doctor
						위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}인\\
						위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}인\\
						\fi
						\else % 2차 본문 시작 (영어)
						\fontsize {14pt}{16pt}
						\selectfont
						\if@Doctor
						The dissertation for the degree of Doctor of Philosophy by \@EngAuthor\ \\has been approved  by the committee members. \\
						\else
						The thesis for the degree of Master of Science by \@EngAuthor\ \\has been approved by the committee members. \\
						\fi
						\vspace*{1.0cm}
						\textbf{\@EngExamYear}\ \\
						\vspace*{1.0cm}
						\vspace*{-20pt}
						\setstretch{2.0}
						\fontsize {14pt}{16pt}
						\selectfont
						Chair~~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
						Member~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
						Member~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
						\if@Doctor
						Member~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
						Member~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
						\fi
						\fi
                    \end{center}
					% \vspace*{1.5cm}
					\vspace*{3pt}
                \end{minipage}
            \newpage
            }

%chapter 설정
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\thispagestyle{plain}
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{\@chapapp\space\thechapter.}%
		\if@Korean
			\addcontentsline{toc}{chapter}{\numberline{제~\thechapter}~~장 ~#1}
		\else
			\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading%
	\fi
}
\def\@makechapterhead#1{%
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\parindent\z@
	 \fontsize{16pt}{20pt}
	 \selectfont
	 \bfseries
	 \if@Korean
	 	{
			\centering
			\fontsize{16pt}{20pt}
			\selectfont
			제~\thechapter~장~#1
			\par
		}
	 \else
		{Chapter \thechapter \hspace{1ex}
		\vskip 40\p@
		\fontsize{16pt}{20pt}
		\selectfont
		} #1\par
	\fi
	}
	\vskip 40\p@
}
\def\@schapter#1{%
	\if@twocolumn
		\@topnewpage[\@makeschapterhead{#1}]%
	\else
		\@makeschapterhead{#1}%
		\@afterheading
	\fi}
\def\@makeschapterhead#1{
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\centering \parindent\z@
	\fontsize{22pt}{26pt}
	\selectfont
	\bfseries #1\par}
	\vskip 40\p@
}

%% Abstract
\newcounter{pagemarker}
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}}

% \renewenvironment{abstract}{%
%     \pagenumbering{roman}
%     \pagestyle{plain}%
%     \newcommand{\@tempbreak}{}
%     \let\@tempbreak\linebreak
%     \renewcommand{\linebreak}{\ }
%     \newlength{\@thesisinfowidth}
%     \setlength{\@thesisinfowidth}{\textwidth}
%     \addtolength{\@thesisinfowidth}{-20mm}
%     %\noindent
%     \begin{center}
%     \fontsize {22pt}{22pt}
%     \selectfont
%     \textbf{\abstractname} \\
%     \end{center}
%     \vspace{20\p@}
%     \addcontentsline{toc}{chapter}{\abstractname}
% }{  \setcounter{pagemarker}{\value{page}}
%     \addtocounter{pagemarker}{1}
%     \newpage \pagenumbering{arabic}
%     \let\linebreak\@tempbreak
% }

\newenvironment{abstractKOR}{%
    % \pagenumbering{roman}
	\begin{center}
	\setstretch{1.3}	
    \pagestyle{plain}%
	\vspace*{-0.7cm}
	\fontsize{14pt}{14pt}
	\selectfont
	\@KorTitle\ \\
	\vspace*{1.5cm}
	\vspace*{-0.2cm}
	\fontsize{12pt}{12pt}
	\selectfont
	\@KorAuthor\ \\
	\vspace*{1.0cm}
	\vspace*{-0.1cm}
	\fontsize{11pt}{11pt}
	\selectfont
	부산대학교 대학원 물리학과\\
	\vspace*{1.5cm}
	\vspace*{-0.2cm}
	\fontsize{12pt}{12pt}
	\selectfont
	요약\\
	\vspace*{1.0cm}
	\vspace*{-0.0cm}
	\fontsize{11pt}{13pt}
	\selectfont
	\end{center}
	\begin{justify}
}{  %\setcounter{pagemarker}{\value{page}}
    % \addtocounter{pagemarker}{1}
	\end{justify}
    \newpage \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}

\newenvironment{abstractENG}{%
    % \pagenumbering{roman}
	\begin{center}
	\setstretch{1.3}
    \pagestyle{plain}%
	\vspace*{-0.7cm}
	\fontsize{14pt}{14pt}
	\selectfont
	\@EngTitle\ \\
	\vspace*{1.5cm}
	\vspace*{-0.1cm}
	\fontsize{12pt}{12pt}
	\selectfont
	\textbf{\@EngAuthor\ } \\
	\vspace*{1.0cm}
	\vspace*{-0.2cm}
	\fontsize{11pt}{11pt}
	\selectfont
	Department of Physics\\
	The Graduate School\\
	Pusan National University\\
	\vspace*{1.5cm}
	\vspace*{-0.2cm}
	\fontsize{12pt}{12pt}
	\selectfont
	Abstract\\
	\vspace*{1.0cm}
	\vspace*{-0.2cm}
	\fontsize{11pt}{13pt}
	\selectfont
}{  %\setcounter{pagemarker}{\value{page}}
    % \addtocounter{pagemarker}{1}
	\end{center}
    \newpage \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}

%%
%% 목차
%%
\newcommand{\makelists}{%
	\pagenumbering{roman}
	\if@Korean
		\tableofcontents
		\clearpage
		% \listoftables
		% \clearpage
		\listoffigures
		\clearpage
	\else
		\tableofcontents
		\clearpage
		% \listoftables
		\listoffigures
		\clearpage
	\fi
	\if@Korean
	\pushAbstract[korean]
	\else
	\pushAbstract[english]
	\fi
	\pagenumbering{arabic}
}

% Typesetting for toc, tot, tof
\if@Korean
	% TOC
    \setlength{\cftbeforetoctitleskip}{0pt}
	\renewcommand{\cftaftertoctitle}{\hfill}
	\renewcommand{\cfttoctitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOF
    \setlength{\cftbeforeloftitleskip}{0pt}
	\renewcommand{\cftafterloftitle}{\hfill}
	\renewcommand{\cftloftitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOT
    \setlength{\cftbeforelottitleskip}{0pt}
	\renewcommand{\cftafterlottitle}{\hfill}
	\renewcommand{\cftlottitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
\fi

\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}} 
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\contentsname}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
% \fi

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\if@Korean\else
\renewcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listtablename}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
\fi

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\if@Korean\else
\renewcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listfigurename}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
\fi

\newcommand{\acknowledgement}{%
    % \vspace{-1cm}
	\if@Korean
		\chapter*{감사의 글}
		\addcontentsline{toc}{chapter}{감사의 글}
	\else
		\chapter*{ACKNOWLEGEMENT}
		\addcontentsline{toc}{chapter}{Acknowlegement}
	\fi
    \pagestyle{empty}
    \indent
}
