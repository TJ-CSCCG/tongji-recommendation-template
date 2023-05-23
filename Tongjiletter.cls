%
% Tongjiletter.cls -- A document class for writing letters with Tongji letterhead
% This class is based on "brownletter.cls" Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
% Last version modifications by Shaozuo Yu
% (AugustYum@outlook.com), March 8, 2020
%
% This version is modified and maintained by Rizhong Lin
% (rizhonglin@tongji.edu.cn), May 22, 2023
%
% Notes:
%
% 1. This class can be used to create letters with the Tongji logo in the header and the department address in the footer.
% 2. It is based on the standard LaTeX document class, letter.cls.
% 3. If the Tongji logo is to be included in the header, the file Tongji.pdf must be provided; otherwise, the logo is omitted.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Tongjiletter}

\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}

\DeclareGraphicsExtensions{.png}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter}

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newboolean{logofound}
\IfFileExists{Tongji.pdf}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\sbox{\departmenthead}{%
    \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}
        \parbox{4.0in}{\raggedright
            \ifthenelse{\boolean{logofound}}
                {\vspace{0.3in}\includegraphics[height=1.1in]{Tongji.pdf}}
                {\parbox[t][2.0in][t]{3.0in}{\hfill} 
                \ClassWarning{Tongjiletter}{Tongji.pdf COULD NOT BE FOUND!}}
        } &
        \parbox[t][1in][t]{2in}{{~}\\}
    \end{tabular*}%
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

\renewcommand{\ps@firstpage}{%
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{%
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\pagestyle{empty}

\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

\RequirePackage{varwidth}

\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hfill\begin{varwidth}{\textwidth}\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut\end{varwidth}%
    \par
}
