%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Medium Length Professional CV - RESUME CLASS FILE
%
% This template has been downloaded from:
% http://www.LaTeXTemplates.com
%
% This class file defines the structure and design of the template.
%
% Original header:
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
% Created by Trey Hunner and modified by www.LaTeXTemplates.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2010/07/10 v0.9 Resume class]

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\usepackage{wrapfig}
\usepackage{graphicx}
\usepackage{color}
\usepackage{stix}  % Provides the "very small white circle" used as a bullet for sub-lists
\usepackage{microtype}
\usepackage{multicol} %columns for lists
\setlength\multicolsep{0pt} %remove space before and after multicol

\usepackage{hyperref} %links - http and mailto
\hypersetup{hidelinks} %hide boxes around links
%check out other hyperref options
\usepackage{fontawesome}
\let\orighref\href
\renewcommand{\href}[2]{\orighref{#1}{#2\,{\tiny \faExternalLink}}}  % Add icon next to all links

\def\sectionskip{\smallskip} % The space after the heading section
\def\nameskip{\medskip} % The space after your name at the top
\def\addressskip{} % The space between the two address (or phone/email) lines

% More sophisticated bibliography styling and printing. Looks for custom biblatex.cfg file in same directory.
\usepackage[backend=biber]{biblatex}

\pagestyle{empty} % Suppress page numbers

% Flag for switching on/off content specific to CV (extended) format
\newboolean{isCV}
\setboolean{isCV}{true}

% Flag for switching on/off "title only" content
\newboolean{titleOnly}
\setboolean{titleOnly}{false}

%----------------------------------------------------------------------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \footername#1{\def\@footername{#1}} % Defines the \footername command to set footername
\def \@footername {} % Sets \@footername to empty by default

\def \addressSep {$\diamond$} % Set default address separator to a diamond

% One, two or three address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addressone}{
    \def \@addressone {#1}
  }{
    \@ifundefined{@addresstwo}{
      \def \@addresstwo {#1}
    }{
      \@ifundefined{@addressthree}{
        \def \@addressthree {#1}
      }{}
    }
  }
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\namesize\bf \@name}\hfil
    \nameskip\break
  \endgroup
}

\def \icon#1#2{\def\@icon{#2} \def\@iconwidth{#1}}

% \printicon is used to place an icon in the top right corner
\def \printicon {
  \ifthenelse{\isundefined{\@icon}}{}{
	\begingroup
		\begin{wrapfigure}{r}{0.51in}
      \vspace{-2ex}
			\includegraphics[width=\@iconwidth]{\@icon}
		\end{wrapfigure}
		{\tiny \color{white} .}
	\endgroup
  }
}

%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printicon
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
     \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
}

\newboolean{inSubection}
\newenvironment{rSubsection}[1]{
  \sectionskip
  {\bf #1}
  \setboolean{inSubection}{true}
  \begin{rBulletList}
}{
  \end{rBulletList}
  \setboolean{inSubection}{false}
}

\newenvironment{rSectionHeading}[1]{ % 1 input argument - section name
  \sectionskip
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
}{}

%----------------------------------------------------------------------------------------
%	PUBLICATIONS FORMATTING
%----------------------------------------------------------------------------------------

\def \mybibtitle{}
% Leverages the bibliography to print a list of publications
\newcommand{\mybibliography}[3]{
  \def \mybibtitle {#1}
  \nocite{*}
  \printbibliography[prefixnumbers={#2},resetnumbers=1,omitnumbers=false,heading=mybibheading,keyword={#3}]
}
\defbibheading{mybibheading}{\smallbreak \normalfont\selectfont\normalsize \bf \mybibtitle }

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newcounter{rBulletDepth}  % Keep track of how deep we are nested
\newenvironment{rBulletList}[1][1]{%
  \stepcounter{rBulletDepth}
  \ifthenelse{\isodd{\value{rBulletDepth}}}{% Change the symbol we use based on the depth
    \def \rBulletSymbol{$\cdot$}}{%
    \def \rBulletSymbol{$\vysmwhtcircle$}  }
  % \ifthenelse{\value{rBulletDepth}>1}{% Set margin to 0 if at the first level, do nothing otherwise
    % \def \rBulletMargin{}  }{%
    % \def \rBulletMargin{\leftmargin=0em}  }
    % \def \rBulletMargin{\leftmargin=1em}  }
  % Set margin to the level of depth * em
  \def \rBulletMargin{\leftmargin=\value{rBulletDepth}em}
  \def \rNumCols{#1}
  \ifthenelse{\rNumCols>1}{%
    \begin{multicols}{\rNumCols}
    \begin{list}{\rBulletSymbol}{\rBulletMargin} % \cdot used for bullets, no indentation
     \itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
  }{%
    \begin{list}{\rBulletSymbol}{\rBulletMargin} % \cdot used for bullets, no indentation
     \itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
     \ifthenelse{\boolean{inSubection}}{}{\vspace{1ex}}
   }
  }{
  \end{list}
  \ifthenelse{\rNumCols>1}{\end{multicols}}{}
  \addtocounter{rBulletDepth}{-1}

  %\vspace{0.5em} % Some space after the list of bullet points
}

\newenvironment{rExperienceHeader}[4]{ % 4 input arguments - company name, year(s) employed, job title and location
 {\bf #1} \hfill {\em #2} % Bold company name and italic date on the right
 \ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
  \\
  {#3} \hfill {#4} % Job title and location

  }\smallskip
  \setboolean{inSubection}{true}
  }{
  \setboolean{inSubection}{false}
}

\newenvironment{rExperienceBullets}[4]{ %
  \begin{rExperienceHeader}{#1}{#2}{#3}{#4}
  \begin{rBulletList}
  }{
  \end{rBulletList}
  \end{rExperienceHeader}
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section

%----------------------------------------------------------------------------------------
%	FOOTER COMMNADS: PRINT THE MODIFIED DATE OF THE MAIN .TEX FILE
%----------------------------------------------------------------------------------------

\usepackage[left=0.75in,top=0.75in,right=0.75in,bottom=0.75in]{geometry} % Document margins
\usepackage{filemod}
\renewcommand{\thefilemoddate}[3]{#2/#3/#1}
\usepackage{fancyhdr} %for adding a footer
\pagestyle{fancy}
\usepackage{lastpage} % For getting the last page number
\renewcommand{\headrulewidth}{0pt}
\lhead{}
\chead{}
\rhead{}
\lfoot{\scriptsize \@footername}
\cfoot{\scriptsize \textit{Revised \filemodprintdate{\jobname}}}
\rfoot{\scriptsize \ifthenelse{\pageref{LastPage}>2}{\thepage}{}}
