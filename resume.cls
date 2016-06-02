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

\setlength{\parindent}{0pt}
\setlength{\parskip}{6.8pt plus 2.0pt}
\setlength{\parsep}{6.8pt plus 2.0pt}
\setlength{\topsep}{0pt}
\setlength{\itemsep}{0pt}
\setlength{\partopsep}{0pt}
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\usepackage{wrapfig}
\usepackage{graphicx}
\usepackage{stix}  % Provides the "very small white circle" used as a bullet for sub-lists
\usepackage{microtype} % Helps things fit better horizontally
\usepackage{multicol} %columns for lists
\setlength\multicolsep{0pt} %remove space before and after multicol
\usepackage{environ} % Allows for the \NewEnviron command
\usepackage{xkeyval} % Processes keyword arguments

\usepackage{hyperref} %links - http and mailto
\hypersetup{hidelinks} %hide boxes around links
%check out other hyperref options
\usepackage{fontawesome} % Required for new definition of \href
\let\orighref\href % Store the original \href command
\renewcommand{\href}[2]{\orighref{#1}{#2\,{\tiny \faExternalLink}}}  % Add icon next to all links

\usepackage{quoting} % Equivalent to the quote environment without the spacing before and after
\quotingsetup{vskip=0pt}

% Some pre-defined skips for different document locations
\def\sectionskip{\smallskip} % The space after the heading section
\def\nameskip{\medskip} % The space after your name at the top
\def\addressskip{} % The space between the two address (or phone/email) lines

% More sophisticated bibliography styling and printing. Looks for custom biblatex.cfg file in same directory.
\usepackage[backend=biber]{biblatex}

\pagestyle{empty} % Suppress page numbers

\usepackage{needspace} % Allows us to specify when a certain number of lines need to be on the same page
\def\bibSpace{3\baselineskip}
\def\subsecSpace{2\baselineskip}
\def\secHeadSpace{7\baselineskip}
\def\expHeaderSpace{3\baselineskip}

\usepackage{scrextend} % Allows us to specify custom margins for whole blocks of code

% Flag for switching on/off content specific to CV (extended) format
\newboolean{isCV}
\setboolean{isCV}{true}
\def\isCV{\boolean{isCV}}

% Flag for switching on/off "title only" content
\newboolean{titleOnly}
\setboolean{titleOnly}{false}

%----------------------------------------------------------------------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

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
		\end{wrapfigure}~ % Without the ~, the icon goes to the end of the document
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
  \noindent
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

\define@boolkey{rSectionFlags}{titleOnly}[true]{}

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[2][titleOnly=false]{ % 2 input arguments - titleOnly flag and section name
  \setkeys{rSectionFlags}{#1} % Process the titleOnly flag
  % Determine whether or not to set the global flag of titleOnly on or not
  \ifKV@rSectionFlags@titleOnly
  \setboolean{titleOnly}{true}
  \fi
  % Start the section
  \begin{rSectionHeading}{#2}
    \begin{addmargin}[1.5em]{0pt} % Margin within the section
}{
    \end{addmargin}
  \end{rSectionHeading}
  \setboolean{titleOnly}{false}
}

\newenvironment{rBulletSubsection}[1]{
  \needspace{\subsecSpace}
  {\bf #1}
  \begin{rBulletList}
}{
  \end{rBulletList}
}

\newenvironment{rSectionHeading}[1]{ % 1 input argument - section name
  \sectionskip
  \needspace{\secHeadSpace}
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
}{}

\newenvironment{rBulletSection}[2][1]{
  \setboolean{addListSkip}{true}
  \begin{rSection}{#2}
    \begin{rBulletList}[#1]
}{
    \end{rBulletList}
  \end{rSection}
}

%----------------------------------------------------------------------------------------
%	PUBLICATIONS FORMATTING
%----------------------------------------------------------------------------------------

% Leverages the bibliography to print a list of publications
\newcommand{\mybibliography}[3]{
  \nocite{*}
  % Note: The "keyword" parameter is conjunctive if specified multiple times, not disjunctive.
  \printbibliography[prefixnumbers={#2},resetnumbers=1,omitnumbers=false,heading=mybibheading,keyword={#3},title=#1]%
  \vspace{-\parskip}
}
\defbibheading{mybibheading}{ \needspace{\bibSpace} \normalfont\selectfont\normalsize \bf #1 \vspace{-2\parskip} }

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newcounter{rBulletDepth}  % Keep track of how deep we are nested
% The difference between the vertical space before a regular list (0pt) and a multicol environment containing a list is a 3 pt length, or a single \smallskip. If a multicol list comes right after a header, it needs one \smallskip to have the same spacing as other content, which means a normal list needs two \smallskip, or one \medskip.
\newboolean{addListSkip}
\setboolean{addListSkip}{false}

\newenvironment{rBulletList}[1][1]{%
  \stepcounter{rBulletDepth}
  \ifthenelse{\isodd{\value{rBulletDepth}}}{% Change the symbol we use based on the depth
    \def \rBulletSymbol{$\cdot$}}{%
    \def \rBulletSymbol{$\vysmwhtcircle$}  }
  % Set margin to the level of depth * em
  \def \@rBulletSettings{
    \setlength{\leftmargin}{\value{rBulletDepth}em}
    \setlength{\parskip}{0pt}
    \setlength{\topsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\itemsep}{0pt}
    \setlength{\partopsep}{0pt}
    \setlength{\labelwidth}{0.5em} % Keeps left edge of item paragraphs aligned (when wrapping) because it is wider than either of the symbols used as bullets
  }
  \def \rNumCols{#1}
  \ifthenelse{\rNumCols>1}{%
    \ifthenelse{\boolean{addListSkip}}{\smallskip\setboolean{addListSkip}{false}}{}
    \begin{multicols}{\rNumCols}
    \begin{list}{\rBulletSymbol}{\@rBulletSettings}
  }{%
    \ifthenelse{\boolean{addListSkip}}{\medskip\setboolean{addListSkip}{false}}{}
    \begin{list}{\rBulletSymbol}{\@rBulletSettings}
   }
  }{
  \end{list}
  \ifthenelse{\rNumCols>1}{\end{multicols}}{}
  \addtocounter{rBulletDepth}{-1}
}

\NewEnviron{rExperience}[4]{
  \ifthenelse{\boolean{titleOnly}}{
    \begin{rExperienceHeader}{#1}{#2}{#3}{#4} \end{rExperienceHeader}
  }{
  \begin{rExperienceBullets}{#1}{#2}{#3}{#4}
    \BODY
  }
}[\ifthenelse{\boolean{titleOnly}}{}{\end{rExperienceBullets}}]

\newenvironment{rExperienceHeader}[4]{ % 4 input arguments - company name, year(s) employed, job title and location
  \needspace{\expHeaderSpace}
  {\bf #1} \hfill {\em #2} % Bold company name and italic date on the right
  \ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
  \\
  {#3} \hfill {#4} % Job title and location

  }\smallskip
}{}

\newenvironment{rExperienceBullets}[4]{ %
  \begin{rExperienceHeader}{#1}{#2}{#3}{#4}
  \begin{rBulletList}
}{
  \end{rBulletList}
  \end{rExperienceHeader}
}

\NewEnviron{CVonly}{\ifthenelse{\boolean{isCV}}{\BODY}{}}
\newcommand{\rCVonly}[1]{\ifthenelse{\boolean{isCV}}{#1}{}}

\NewEnviron{ResumeOnly}{\ifthenelse{\boolean{isCV}}{}{\BODY}}
\newcommand{\rResumeOnly}[1]{\ifthenelse{\boolean{isCV}}{}{#1}}


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
% Set the headers and the right and left footers to be empty
\lhead{}
\chead{}
\rhead{}

% Split up the footer values according to which ones are defined

% Define the \footername command to set footername and set the default to be empty
\newboolean{footerNameDefd}
\setboolean{footerNameDefd}{FALSE}
\def\footername#1{\def\@footername{#1} \setboolean{footerNameDefd}{TRUE}}
\def\@footername{}

% Define the command to set the threshold for showing the page number and set the default to 2
\usepackage{xstring}  % Allows us to check that the parameter is an Integer
\def\setShowPageThreshold#1{\IfInteger{#1}{\def\@showPageThreshold{#1}}{\def\@showPageThreshold{2}}}
\def\@showPageThreshold{2}
\def\@rPageVal{\ifthenelse{\pageref{LastPage}>\@showPageThreshold}{\thepage}{}}
\newboolean{showPage}
\def\showPageNumbers{\setboolean{showPage}{TRUE}}
\def\hidePageNumbers{\setboolean{showPage}{FALSE}}
\ifthenelse{\isCV}{\showPageNumbers}{\hidePageNumbers} % Set default to be the same as \isCV

% Define the command to hide the revised date
\newboolean{showRevisedDate}
\setboolean{showRevisedDate}{TRUE}
\def \hideRevisedDate{\def \@rRevisedDate{} \setboolean{showRevisedDate}{FALSE}}
\def \@rRevisedDate {\textit{Revised \filemodprintdate{\jobname}}}

\def \@lfootval{%
  \ifthenelse{\boolean{footerNameDefd} \AND \( \boolean{showRevisedDate} \OR \boolean{showPage} \)}{%
    % Footer name is defined an either the revised date or the page number
    \@footername%
  }{%
    \ifthenelse{\boolean{showRevisedDate} \AND \boolean{showPage}}{%
      \@rRevisedDate%
    }{}%
  }%
}

\def \@cfootval{%
  \ifthenelse{\boolean{showPage} \AND \NOT \( \boolean{footerNameDefd} \OR \boolean{showRevisedDate} \)}{%
    % Only the page number is defined
    \@rPageVal%
  }{%
  \ifthenelse{\boolean{footerNameDefd} \AND \NOT \( \boolean{showRevisedDate} \OR \boolean{showPage} \)}{%
    % Only the footer name is defined
    \@footername%
  }{%
  \ifthenelse{\boolean{showRevisedDate} \AND \(%
        \( \boolean{footerNameDefd} \AND \boolean{showPage} \) \OR%
        \( \NOT \( \boolean{footerNameDefd} \OR \boolean{showPage} \)\)\)}{%
    \@rRevisedDate%
  }{}%
  }%
  }%
}

\def \@rfootval{%
  \ifthenelse{\boolean{showPage} \AND \( \boolean{footerNameDefd} \OR \boolean{showRevisedDate} \)}{%
    % Page number is defined and either the footer name or the revised date
    \@rPageVal%
  }{%
    \ifthenelse{\boolean{footerNameDefd} \AND \boolean{showRevisedDate}}{%
      % Only the footer name and the revised date are defined
      \@rRevisedDate%
    }{}%
  }%
}

\lfoot{\scriptsize \@lfootval}
\cfoot{\scriptsize \@cfootval}
\rfoot{\scriptsize \@rfootval}


%----------------------------------------------------------------------------------------
%	Other custom stuff
%----------------------------------------------------------------------------------------
