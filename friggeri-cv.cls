% Forked from https://github.com/akanosora/friggeri-cv
% Copyright (C) 2012, Adrien Friggeri
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

\ProvidesClass{friggeri-cv}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{silver}{HTML}{808080}
\definecolor{lightgray}{HTML}{AAAAAA}
\definecolor{white}{HTML}{FFFFFF}

\definecolor{green}{HTML}{5DAE61}
\definecolor{orange}{HTML}{FF7141}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{DD4C39}
\definecolor{blue}{HTML}{5397D5}
\definecolor{wine}{HTML}{A2033c}

\ifdefined\@cv@print
  \colorlet{green}{darkgray}
  \colorlet{orange}{darkgray}
  \colorlet{purple}{darkgray}
  \colorlet{red}{darkgray}
  \colorlet{blue}{darkgray}
  \colorlet{filltitle}{white}
  \colorlet{title}{darkgray}
\else
  \colorlet{filltitle}{darkgray}
  \colorlet{title}{white}
\fi
\colorlet{textcolor}{darkgray}
\colorlet{headercolor}{darkgray}

\pagecolor{white}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage{unicode-math}
\defaultfontfeatures{Mapping=tex-text}
\usepackage{xeCJK}       % 支持中文
\setCJKmainfont{Songti SC}

\newfontfamily\firstnamefont{Heiti SC}
\newfontfamily\lastnamefont{Heiti SC}
\newfontfamily\rolefont{Heiti SC}
\newfontfamily\headingfont{Heiti SC}

% \setmainfont[Color=textcolor, Numbers=OldStyle]{Songti SC}
% \setmonofont[ItalicFont=GaramondPremrPro-It, BoldFont=GaramondPremrPro-Smbd]{GaramondPremrPro}
% \setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=filltitle, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{24pt}{36pt}\color{title}\scshape%
      {\firstnamefont #1}~{\lastnamefont #2}%
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{title}%
      \rolefont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}

%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        green\or%
        blue\or%
        orange\or%
        red\or%
        purple\else%
        headercolor\fi%
    } #1#2%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}

% \RequirePackage{enumitem}
% \setitemize{noitemsep, leftmargin=\parindent, labelindent=\parindent}

%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.8cm}{%
    \renewcommand{\baselinestretch}{1.2}\selectfont % increase line spacing
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \vspace{1.5\baselineskip}
    \renewcommand\baselinestretch{1.2}\selectfont %change the lineheight
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
    \vspace{.5\baselineskip}
  }
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=numeric, defernumbers=true, maxnames=99, backend=biber]{biblatex}
\setlength\bibhang{0pt}

\defbibenvironment{bibliography}{%
  \list
    {\printfield[labelnumberwidth]{labelnumber}}
    {%
      \setlength{\labelwidth}{\labelnumberwidth}%
      \setlength{\leftmargin}{\labelwidth}%
      \setlength{\labelsep}{\biblabelsep}%
      \addtolength{\leftmargin}{-\labelwidth}% <- Changed
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}%
    }%
  \renewcommand*{\makelabel}[1]{\hss##1}%
}
{\endlist}
{\item}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[book]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}

\def\newblock{\hskip 0pt plus 0pt minus 0pt}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \nopagebreak\newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \textcolor{lightgray}{\printfield{doi}}%
    \newunit%
    \finentry%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{book}{%
  \printfield{title}%
  \nopagebreak\newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
    \finentry%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \nopagebreak\newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
    \finentry%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \nopagebreak\newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{booktitle}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
    \finentry%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \nopagebreak\newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{type}%
    \setunit{\space}%
    \printfield{number}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \newunit%
    \finentry%
  }
  \par\vspace{0.3\baselineskip}
}

% biblatex name formatting changed with version 3.3.
% After this change the line "\ifblank{#3}{}{#3\space}#1%" gives an error.
% See also: http://tex.stackexchange.com/questions/327316/updating-friggeris-cv-making-it-work-with-texlive-2015-and-up-too-many-erro

\DeclareNameFormat{author}{%
  \small\addfontfeature{Color=lightgray}%
  \nameparts{#1}\ifblank{\namepartgiven}{}{\namepartgiven\space}\namepartfamily%
  \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}
    {}%
}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \newrefcontext[sorting=chronological]
    \printbibliography[type={#1}, title={#2}, heading=subbibliography]
  \end{refsection}
}

\DeclareSortingTemplate{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}

%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm, top=2cm, right=1.5cm, bottom=2.5cm, nohead, nofoot]{geometry}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{microtype}
