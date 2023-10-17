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

\ProvidesClass{resume}[2017/06/09 v0.9.2.2 Resume class (Mabey)]

%%%%%%%%%%%%%%%%%%%%%%%%%% Pre-options Section - all imports and variable declarations must go here, before the first \DeclareOptionX
\usepackage{xkeyval} % Processes keyword arguments
\usepackage{pageslts} % For getting the last page number
\usepackage{etoolbox}
% cvmode
\newtoggle{isCV}
% font
\newcommand\@fontselection{doesntexist}
% icon
\newbool{icon@tf@fn}
\setbool{icon@tf@fn}{false}
\def\icon@val@fn{}
\newbool{icon@tf@sz}
\setbool{icon@tf@sz}{false}
\newdimen\icon@val@sz
% showreviseddate
\newbool{showRevisedDate}
% pagethreshold
\usepackage{xstring}  % Allows us to check that the parameter is an Integer
\newcommand\@defaultPageThreshold{}
% show link icon
\newif\iflink@icon
\link@icontrue
% footer name
\newbool{footerNameDefd}
\setbool{footerNameDefd}{false}
\def\@footername{}
% last name (for matching names in bib)
\def\MyLastName{}
%%%%%%%%%%%%%%%%%%%%%%%%%% End of Pre-options Section

% cvmode=true/false
\DeclareOptionX{cvmode}[true]{
  \ifstrequal{#1}{false}{\togglefalse{isCV}}{
  \ifstrequal{#1}{true}{\toggletrue{isCV}}{
    \ClassWarningNoLine{resume}{Invalid\space value\space for\space option\space 'cvmode':\space #1}
  }}
}

% font=name
\DeclareOptionX{font}{\renewcommand\@fontselection{#1}}

% icon=filename
\DeclareOptionX{icon}{\renewcommand{\icon@val@fn}{#1}\setbool{icon@tf@fn}{true}}

% iconsize=size
\DeclareOptionX{iconsize}{\setlength{\icon@val@sz}{#1}\setbool{icon@tf@sz}{true}}

% showreviseddate=true/false
\DeclareOptionX{showreviseddate}[true]{
  \ifstrequal{#1}{false}{}{
  \ifstrequal{#1}{true}{\setbool{showRevisedDate}{true}}{
    \ClassWarningNoLine{resume}{Invalid\space value\space for\space option\space 'showreviseddate':\space #1\MessageBreak Using\space default:\space true}
    \setbool{showRevisedDate}{true}%else
  }}
}

% pagethreshold=#
\DeclareOptionX{pagethreshold}{
  \IfInteger{#1}{\renewcommand\@defaultPageThreshold{#1}}{
    \ClassWarningNoLine{resume}{Invalid\space value\space for\space option\space 'pagethreshold':\space #1
      \MessageBreak Must\space be\space an\space Integer!}
  }
}

% linkicon=true/false
\DeclareOptionX{linkicon}[true]{
  \ifstrequal{#1}{false}{\link@iconfalse}{
  \ifstrequal{#1}{true}{\link@icontrue}{
    \ClassWarningNoLine{resume}{Invalid\space value\space for\space option\space 'linkicon':\space #1}
  }}
}

% footername=
\DeclareOptionX{footername}[]{
  \ifblank{#1}{}{ % Check that length is non-zero
    \setbool{footerNameDefd}{true}
    \renewcommand\@footername{#1}
  }
}

% lastname= % For \MyLastName
\DeclareOptionX{lastname}[]{
  \ifblank{#1}{}{ % Check that length is non-zero
    \renewcommand\MyLastName{#1}
  }
}

% margins % For uniform margins on all four sides
\DeclareOptionX{margins}[0.75in]{
  \PassOptionsToPackage{left=#1,top=#1,right=#1,bottom=#1}{geometry}
}

% vmargins % Margins for top and bottom (vertical)
\DeclareOptionX{vmargins}[0.75in]{
  \PassOptionsToPackage{top=#1,bottom=#1}{geometry}
}

% hmargins % Margins for left and right (horizontal)
\DeclareOptionX{hmargins}[0.75in]{
  \PassOptionsToPackage{left=#1,right=#1}{geometry}
}


% Execute all the default options
\ExecuteOptionsX{margins=0.75in,cvmode=true,font=computermodern,linkicon,pagethreshold=2,showreviseddate}

% Process the given options
\ProcessOptionsX\relax


%%%%%%%%%%%%%%%%%%%%%%%%%%  End of option processing  %%%%%%%%%%%%%%%%%%%%%%%%%%


\LoadClass[11pt,letterpaper]{article} % Font size and paper type


% \usepackage{expl3} % For LaTeX3 commands
% \ExplSyntaxOn
% \newcommand*{\loadfont}[1]{%
  % % Shout out to Christian Hupfer whose examples at http://tex.stackexchange.com/questions/314302/good-examples-of-tl-casenntf-and-str-casenntf helped me make sense of \str_case
  % \str_case_x:nnTF{#1} {%
    % {berasans}{\usepackage[T1]{fontenc}\usepackage[]{berasans}\renewcommand*\familydefault{\sfdefault}}%
    % {cantarell}{\usepackage[T1]{fontenc}\usepackage[default, scale=0.95]{cantarell}}%
    % {computermodern}{\usepackage[T1]{fontenc}\renewcommand*{\familydefault}{\sfdefault}}%
    % {lato}{\usepackage[T1]{fontenc}\usepackage[default, scale=0.95]{lato}}%
    % {quattrocento}{\usepackage[T1]{fontenc}\usepackage[sfdefault]{quattrocento}}%
    % {sourcesanspro}{\usepackage[T1]{fontenc}\usepackage[default,semibold]{sourcesanspro}}%
    % % I can't recommend any of these fonts, but they'll work
    % {alegreya}{\usepackage[T1]{fontenc}\usepackage[sfdefault]{AlegreyaSans}}%
    % {alegreyablack}{\usepackage[T1]{fontenc}\usepackage[sfdefault,black]{AlegreyaSans}}%
    % {biolinum}{\usepackage[T1]{fontenc}\usepackage{libertine}\renewcommand*\familydefault{\sfdefault}}%
    % {cabin}{\usepackage[T1]{fontenc}\usepackage[sfdefault]{cabin}}%
    % {cabinc}{\usepackage[T1]{fontenc}\usepackage[sfdefault,condensed]{cabin}}%
    % {comfortaa}{\usepackage[T1]{fontenc}\usepackage[default]{comfortaa}}%
    % {cmbright}{\usepackage[T1]{fontenc}\usepackage{cmbright}}%
    % {dejavusans}{\usepackage[T1]{fontenc}\usepackage{DejaVuSans}\renewcommand*\familydefault{\sfdefault}}%
    % {dejavuc}{\usepackage[T1]{fontenc}\usepackage{DejaVuSansCondensed}\renewcommand*\familydefault{\sfdefault}}%
    % {droidsans}{\usepackage[T1]{fontenc}\usepackage[defaultsans]{droidsans}\renewcommand*\familydefault{\sfdefault}}%
    % {firasans}{\usepackage[T1]{fontenc}\usepackage[sfdefault]{FiraSans}}%
    % {gfsneohellenic}{\usepackage[default]{gfsneohellenic}\usepackage[LGR,T1]{fontenc}}%
    % {gillius}{\usepackage[T1]{fontenc}\usepackage[default]{gillius}}%
    % {iwona}{\usepackage[math]{iwona}\usepackage[T1]{fontenc}}%
    % {iwonac}{\usepackage[condensed,math]{iwona}\usepackage[T1]{fontenc}}%
    % {iwonal}{\usepackage[light,math]{iwona}\usepackage[T1]{fontenc}}%
    % {iwonalc}{\usepackage[light,condensed,math]{iwona}\usepackage[T1]{fontenc}}%
    % {kurier}{\usepackage[math]{kurier}\usepackage[T1]{fontenc}}%
    % {kurierc}{\usepackage[condensed,math]{kurier}\usepackage[T1]{fontenc}}%
    % {kurierl}{\usepackage[light,math]{kurier}\usepackage[T1]{fontenc}}%
    % {kurierlc}{\usepackage[light,condensed,math]{kurier}\usepackage[T1]{fontenc}}%
    % {lmodern}{\usepackage{lmodern}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {lmodernex}{\renewcommand*\sfdefault{lmssq}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {libris}{\usepackage{libris}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {lxfonts}{\usepackage[T1]{fontenc}\usepackage{lxfonts}}%
    % {merriweather}{\usepackage[T1]{fontenc}\usepackage[sfdefault]{merriweather}}%
    % {merriweatherl}{\usepackage[T1]{fontenc}\usepackage[sfdefault,light]{merriweather}}%
    % {mintspirit}{\usepackage[T1]{fontenc}\usepackage[default]{mintspirit}}%
    % {opensans}{\usepackage[default,osfigures,scale=0.95]{opensans}\usepackage[T1]{fontenc}}%
    % {paratype}{\usepackage{paratype}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {paratypecap}{\usepackage{PTSansCaption}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {paratypen}{\usepackage{PTSansNarrow}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {raleway}{\usepackage[T1]{fontenc}\usepackage[default]{raleway}}%
    % {roboto}{\usepackage[sfdefault]{roboto}\usepackage[T1]{fontenc}}%
    % {robotoc}{\usepackage[sfdefault,condensed]{roboto}\usepackage[T1]{fontenc}}%
    % {robotol}{\usepackage[sfdefault,light]{roboto}\usepackage[T1]{fontenc}}%
    % {robotolc}{\usepackage[sfdefault,light,condensed]{roboto}\usepackage[T1]{fontenc}}%
    % {robotot}{\usepackage[sfdefault,thin]{roboto}\usepackage[T1]{fontenc}}%
    % {tgadventor}{\usepackage{tgadventor}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {tgheros}{\usepackage{tgheros}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {universal}{\usepackage[default]{uni}\usepackage[OT1]{fontenc}}%
    % {urwgothic}{\usepackage{avant}\renewcommand*\familydefault{\sfdefault}}%
    % {urwnimbus}{\usepackage[scaled]{helvet}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {venturis}{\usepackage[lf]{venturis}\renewcommand*\familydefault{\sfdefault}\usepackage[T1]{fontenc}}%
    % {none}{}%
  % }{}{\ClassWarningNoLine{resume}{Invalid~font~option~given,\space falling~back~to~default:~computermodern}
      % \renewcommand*{\familydefault}{\sfdefault}}%
% }
% \ExplSyntaxOff
% \loadfont{\@fontselection} % \@fontselection must NOT have trailing {} or it won't match the strings above

\usepackage[T1]{fontenc}\usepackage[default, scale=0.95]{cantarell}


\usepackage{geometry} % Document margins

\pretolerance=7000
\setlength{\parindent}{0pt}
\setlength{\parskip}{6.8pt plus 2.0pt}
\setlength{\parsep}{6.8pt plus 2.0pt}
\setlength{\topsep}{0pt}
\setlength{\itemsep}{0pt}
\setlength{\partopsep}{0pt}
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{tabularx}
\usepackage{multirow}

\usepackage{wrapfig}
\usepackage{graphicx}
\usepackage{microtype} % Helps things fit better horizontally
\usepackage{multicol} %columns for lists
\setlength\multicolsep{0pt} %remove space before and after multicol
\usepackage{environ} % Allows for the \NewEnviron command
\usepackage{xparse} % Advanced environment declarations (multiple optional arguments)

\usepackage{hyperref} %links - http and mailto
\urlstyle{same}
\hypersetup{hidelinks} %hide boxes around links
%check out other hyperref options
\iflink@icon
  \usepackage{fontawesome} % Required for new definition of \href
  \usepackage{ocg-p} % Allows hiding the icon when printing
  \let\orighref\href % Store the original \href command
  % Next line needs a counter (I think) to keep the ID unique
  % See http://tex.stackexchange.com/questions/103824/how-to-disappear-text-or-figures-by-printing for an example
  % \renewcommand{\href}[2]{\orighref{#1}{#2\begin{ocg}[printocg=never]{linkIcons}{linkId}{1}\,{\tiny \faExternalLink}\end{ocg}}}  % Add icon next to all links
  \renewcommand{\href}[2]{\orighref{#1}{#2\,{\tiny \faExternalLink}}}  % Add icon next to all links
  \let\origurl\url % Store the original \url command
  \renewcommand{\url}[1]{\origurl{#1}\href{#1}{}}  % Add icon next to all links
  \newcommand{\mailto}[1]{\orighref{mailto:#1}{#1}}
\fi

\usepackage{quoting} % Equivalent to the quote environment without the spacing before and after
\quotingsetup{vskip=0pt}

% Don't allow hyphenation. This might cause some horizontal spacing problems, but it makes the document easier
% to read for machines.
\hyphenpenalty=10000

\def\namesize{\huge} % Size of the name at the top of the document
% Some pre-defined skips for different document locations
% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\sectionskip{\penalty-200\vspace{3pt plus 12pt minus 4pt}} % The space after the heading section
\def\sectionlineskip{\vspace{6pt}} % The space above the horizontal line for each section
\def\postsectionskip{\vspace{0pt plus 2pt minus 0pt}}
\def\nameskip{\vspace{6pt}} % The space after your name at the top
\def\addressskip{\vspace{-8pt}} % The space between the two address (or phone/email) lines
\def\bibheadingskip{\vspace{-2\parskip}} % The space after the bib heading and before the first entry
\def\emptybibheadingskip{\vspace{-\parskip}} % The space before the first bib entry when there is no heading
\def\bibpostskip{\vspace{-4\parskip}} % The space at the end of the bibliography before any other content
\def\postexpheaderskip{\vspace{3pt plus 2pt minus 1pt}}
\def\preexpskip{\vspace{0pt plus 0pt minus 2pt}}
\def\postexpskip{\penalty-100\vspace{0pt plus 7pt minus 0pt}}

% More sophisticated bibliography styling and printing. Looks for custom biblatex.cfg file in same directory.
\usepackage[backend=biber]{biblatex}

\pagestyle{empty} % Suppress page numbers

\usepackage{needspace} % Allows us to specify when a certain number of lines need to be on the same page
\def\bibSpace{2\baselineskip}
\def\subsecSpace{2\baselineskip}
\def\secHeadSpace{4\baselineskip}
\def\expHeaderSpace{3\baselineskip}

\usepackage{scrextend} % Allows us to specify custom margins for whole blocks of code

% Macro for switching on/off content specific to CV (extended) format
\def\setNotCV{%
  \togglefalse{isCV}%
  \hidePageNumbers%
}

% Flag for switching on/off "title only" content
\newbool{titleOnly}
\setbool{titleOnly}{false}

%----------------------------------------------------------------------------------------
% HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

% \def \addressSep {$\diamond$} % Set default address separator to a diamond
\def \addressSep {\enspace} % Set default address separator to a diamond

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
    \addressskip
  \endgroup
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\namesize\bf \@name}\hfil
    \nameskip
  \endgroup
}

\def \icon#1#2{\def\icon@val@fn{#2} \setlength{\icon@val@sz}{#1} \setbool{icon@tf@fn}{true} \setbool{icon@tf@sz}{true}}

% \printicon is used to place an icon in the top right corner
\def \printicon {
  \ifboolexpr{bool{icon@tf@fn} and bool{icon@tf@sz}}{
  \begingroup
    \begin{wrapfigure}{r}{\icon@val@sz}
      \vspace{-2ex}
      \includegraphics[width=\icon@val@sz]{\icon@val@fn}
    \end{wrapfigure}~ % Without the ~, the icon goes to the end of the document
  \endgroup
  }{
    \ifboolexpr{bool{icon@tf@fn} or bool{icon@tf@sz}}
      {\ClassError{resume}{You\space must\space give\space a\space filename\space *and*\space a\space size\space to\space use\space the\space icon\space option.}
      {If\space you\space did\space provide\space both,\space try\space making\space sure\space the\space size\space is\space a\space dimension.}}{}
  }
}

%----------------------------------------------------------------------------------------
% PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \pagenumbering{arabic} % Needed by the pageslts package to get the last page number
  \printicon
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
  \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
  \noindent
  \vspace{-2\parskip} % Remove some of the space before the first section
  \@clear@exp@vars{}% Reset the experience fields back to empty
}

%----------------------------------------------------------------------------------------
% SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Counters for PDF Index creation
\newcounter{rSectionCount}
\newcounter{rSubSectionCount}[rSectionCount]

\define@boolkey{rSectionFlags}{titleOnly}[true]{}

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[2][titleOnly=false]{ % 2 input arguments - titleOnly flag and section name
  \setkeys{rSectionFlags}{#1} % Process the titleOnly flag
  % Determine whether or not to set the global flag of titleOnly on or not
  \ifKV@rSectionFlags@titleOnly
  \setbool{titleOnly}{true}
  \fi
  % Start the section
  \begin{rSectionHeading}{#2}
    \begin{addmargin}[0em]{0pt} % Margin within the section
}{
    \end{addmargin}
  \end{rSectionHeading}
  \setbool{titleOnly}{false}
}

\newenvironment{rBulletSubsection}[1]{
  \preexpskip
  \Needspace*{\subsecSpace}
  \stepcounter{rSubSectionCount}
  \pdfbookmark[1]{#1}{ss:\Roman{rSectionCount}\roman{rSubSectionCount}}
  {\bf #1}
  \begin{rBulletList}
}{
  \end{rBulletList}
  \postexpskip
}

\newenvironment{rSectionHeading}[1]{ % 1 input argument - section name
  \sectionskip
  \Needspace*{\secHeadSpace}
  \stepcounter{rSectionCount}
  \pdfbookmark[0]{#1}{s:\Roman{rSectionCount}}
  \MakeUppercase{{\bf #1}} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \postsectionskip
}{}

\newenvironment{rBulletSection}[2][1]{
  \setbool{addListSkip}{true}
  \begin{rSection}{#2}
    \preexpskip
    \begin{rBulletList}[#1]
}{
    \end{rBulletList}
    \postexpskip
  \end{rSection}
}

%----------------------------------------------------------------------------------------
% PUBLICATIONS FORMATTING
%----------------------------------------------------------------------------------------

% Leverages the bibliography to print a list of publications
\newcommand{\@mybibtitle}{}
\newcommand{\mybibliography}[3]{
  \newrefcontext[labelprefix={#2}] % Required for biblatex >=3.4, released 2016-05-10
  \renewcommand{\@mybibtitle}{#1}
  \nocite{*}
  % Note: The "keyword" parameter is conjunctive if specified multiple times, not disjunctive.
  \printbibliography[resetnumbers=1, omitnumbers=false, heading=mybibheading, keyword={#3}, postnote=remove_post_vspace]%
}
\defbibheading{mybibheading}{%
  \Needspace*{\bibSpace}%
  \ifdefempty{\@mybibtitle}{}{\stepcounter{rSubSectionCount} \pdfbookmark[1]{\@mybibtitle}{b:\Roman{rSectionCount}\roman{rSubSectionCount}}}%
  \normalfont\selectfont\normalsize \bf \@mybibtitle%
  \ifdefempty{\@mybibtitle}{\emptybibheadingskip}{\bibheadingskip}%
}
\defbibnote{remove_post_vspace}{\bibpostskip}

%----------------------------------------------------------------------------------------
% WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newcounter{rBulletDepth}  % Keep track of how deep we are nested
% The difference between the vertical space before a regular list (0pt) and a multicol environment containing a list is a 3 pt length, or a single \smallskip. If a multicol list comes right after a header, it needs one \smallskip to have the same spacing as other content, which means a normal list needs two \smallskip, or one \medskip.
\newbool{addListSkip}
\setbool{addListSkip}{false}

% Allows smaller text (the bullet below) to be centered vertically with the rest of the line
\newsavebox{\rbulletbox}
\newcommand*{\mlap}[1]{\sbox{\rbulletbox}{#1}\raisebox{0.5\ht\rbulletbox}{\usebox{\rbulletbox}}}

\def\rBulletSymbolOdd{$\cdot$}
% \def\rBulletSymbolEven{\mlap{\tiny\faAngleRight}}
\def\rBulletSymbolEven{\mlap{\fontsize{3pt}{3pt}\faCircleO}}

\newenvironment{rBulletList}[1][1]{%
  \stepcounter{rBulletDepth}
  \ifnumodd{\value{rBulletDepth}}{% Change the symbol we use based on the depth
    \def \@rBulletSymbol{\rBulletSymbolOdd}}{%
    \def \@rBulletSymbol{\rBulletSymbolEven}}
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
  % Try *really* hard to not place a break at the beginning of these lists. Overrides the default value of -51.
  \@beginparpenalty=9000
  \def \@rNumCols{#1}
  \ifnumgreater{\@rNumCols}{1}{%
    \ifbool{addListSkip}{\smallskip\setbool{addListSkip}{false}}{}
    \begin{multicols}{\@rNumCols}
    \begin{list}{\@rBulletSymbol}{\@rBulletSettings}
  }{%
    \ifbool{addListSkip}{\medskip\setbool{addListSkip}{false}}{}
    \begin{list}{\@rBulletSymbol}{\@rBulletSettings}
   }
  }{
  \end{list}
  \ifnumgreater{\@rNumCols}{1}{\end{multicols}}{}
  \addtocounter{rBulletDepth}{-1}
}


% rExperience field variables
\NewDocumentCommand \expPosTitle { G{} }{\global\long\def \@exp@pos{#1}}
\NewDocumentCommand \expPosPeriod { G{} }{\global\long\def \@exp@dates{#1}}
\NewDocumentCommand \expOrgName { G{} }{\global\long\def \@exp@org{#1}}
\NewDocumentCommand \expOrgLoc { G{} }{\global\long\def \@exp@loc{#1}}
\NewDocumentCommand \expExtra { G{} }{\global\long\def \@exp@extra{#1}}
\long\def \@exp@pos{}
\long\def \@exp@dates{}
\long\def \@exp@org{}
\long\def \@exp@loc{}
\long\def \@exp@extra{}
\def\@clear@exp@vars{
  \expPosTitle
  \expPosPeriod
  \expOrgName
  \expOrgLoc
  \expExtra
}
\long\def \@exp@collect@body#1{\def \@exp@body{#1}}



\NewDocumentCommand \setExpOrder { G{tpnl} }{%
  \ifstrequal{#1}{tpnl}{% Title, period, org name, location
    \long\def \@exp@TL{\@exp@pos}%
    \long\def \@exp@TR{\@exp@dates}%
    \long\def \@exp@BL{\@exp@org}%
    \long\def \@exp@BR{\@exp@loc}%
  }{ \ifstrequal{#1}{tlnp}{% Title, location, org name, period
    \long\def \@exp@TL{\@exp@pos}%
    \long\def \@exp@TR{\@exp@loc}%
    \long\def \@exp@BL{\@exp@org}%
    \long\def \@exp@BR{\@exp@dates}%
  }{ \ifstrequal{#1}{nltp}{% Org name, location, title, period
    \long\def \@exp@TL{\@exp@org}%
    \long\def \@exp@TR{\@exp@loc}%
    \long\def \@exp@BL{\@exp@pos}%
    \long\def \@exp@BR{\@exp@dates}%
  }{ \ifstrequal{#1}{nptl}{% Org name, period, title, location -- Trey Hunner's order
    \long\def \@exp@TL{\@exp@org}%
    \long\def \@exp@TR{\@exp@dates}%
    \long\def \@exp@BL{\@exp@pos}%
    \long\def \@exp@BR{\@exp@loc}%
  }{% Default to tpnl if something unsupported was given
    \long\def \@exp@TL{\@exp@pos}%
    \long\def \@exp@TR{\@exp@dates}%
    \long\def \@exp@BL{\@exp@org}%
    \long\def \@exp@BR{\@exp@loc}%
  }}}}%
}
\setExpOrder


% Field formatting options
\let\@expsty@TL \bf
\let\@expsty@TR \em
\let\@expsty@BL \textnormal
\let\@expsty@BR \textnormal
\NewDocumentCommand \setExpStyleTL { G{\bf} }{\let\@expsty@TR #1}
\NewDocumentCommand \setExpStyleTR { G{\em} }{\let\@expsty@TL #1}
\NewDocumentCommand \setExpStyleBL { G{\textnormal} }{\let\@expsty@BR #1}
\NewDocumentCommand \setExpStyleBR { G{\textnormal} }{\let\@expsty@BL #1}


% Collects field variables, sets to default values if not given when called
\NewDocumentEnvironment{rExperience}{ G{\@exp@TL} G{\@exp@TR} G{\@exp@BL} G{\@exp@BR} G{\@exp@extra} }
  {\Collect@Body\@exp@collect@body}% Get everything up until the \end{rExperience} command
  {
    % \ifdefempty{\@exp@extra}
      \def\@last@arg{#4}
      % {\def\@last@arg{#4\\\textnormal{#5}}}
    \ifbool{titleOnly}{
      \togglefalse{fullAddress}
      \begin{rExperienceHeader}{#1}{#2}{#3}{\@last@arg}{}%\ifdefempty{\@exp@extra}{}{\\\textnormal{#5}}} %
      \end{rExperienceHeader}
    }{
    \begin{rExperienceBullets}{#1}{#2}{#3}{\@last@arg}{#5}
        \@exp@body
      \end{rExperienceBullets}
    }
    \@clear@exp@vars{}% Reset the fields back to empty
  }

\newenvironment{rExperienceHeader}[5]{ % 4 input arguments - company name, year(s) employed, job title, location, and extra stuff
  \preexpskip
  \Needspace*{\expHeaderSpace}
  \ifbool{titleOnly}{}{
    \stepcounter{rSubSectionCount}
    \pdfbookmark[1]{\@exp@pos}{ss:\Roman{rSectionCount}\roman{rSubSectionCount}}
  }
  \begin{tabularx}{\linewidth}{@{} >{\raggedright}Xr@{}}
    {\@expsty@TL #1} & {\@expsty@TR #2} \\ % Bold company name and italic date on the right
    {\@expsty@BL #3} & {\@expsty@BR #4}
    % TODO: This was an attempt to make the space after the header be the same when there was and was not an extra line,
    % but it didn't seem to help...
    % \ifblank{#5}{}{\\ \multicolumn{2}{@{}l@{}}{#5}}
  \end{tabularx}%
  % {\@expsty@TL #1} \hfill {\@expsty@TR #2} % Bold company name and italic date on the right
  % \ifblank{#3}{}{ % If the third argument is not specified, don't print the job title and location line
  % \\
  % {\@expsty@BL #3} \hfill {\@expsty@BR #4} % Job title and location
  % }
  \ifblank{#5}{\vspace{-1ex}}{\\#5}%
  \postexpheaderskip%
}{%
  \postexpskip%
}

\newenvironment{rExperienceBullets}[5]{ %
  \begin{rExperienceHeader}{#1}{#2}{#3}{#4}{#5}
  \begin{rBulletList}
}{
  \end{rBulletList}
  \end{rExperienceHeader}
}

\NewEnviron{CVonly}{\iftoggle{isCV}{\BODY}{}}
\newcommand{\rCVonly}[1]{\iftoggle{isCV}{#1}{}}

\NewEnviron{ResumeOnly}{\iftoggle{isCV}{}{\BODY}}
\newcommand{\rResumeOnly}[1]{\iftoggle{isCV}{}{#1}}


%----------------------------------------------------------------------------------------
% FOOTER COMMNADS: PRINT THE MODIFIED DATE OF THE MAIN .TEX FILE
%----------------------------------------------------------------------------------------

\usepackage{filemod}
\renewcommand{\thefilemoddate}[3]{#2/#3/#1}
\usepackage{fancyhdr} %for adding a footer
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
% Set the headers to be empty
\lhead{}
\chead{}
\rhead{}

% Split up the footer values according to which ones are defined

% Define the \footername command to set footername and set the default to be empty
\def\footername#1{\def\@footername{#1} \setbool{footerNameDefd}{true}}
\usepackage{suffix}
\WithSuffix\def\footername*#1{\iftoggle{isCV}{\footername{#1}}{}}

% Define the command to set the threshold for showing the page number and set the default to 2
\def\setShowPageThreshold#1{\IfInteger{#1}{\def\@showPageThreshold{#1}}{\def\@showPageThreshold{\@defaultPageThreshold}}}
\def\@showPageThreshold{\@defaultPageThreshold}
\def\@rPageVal{\ifnumgreater{\value{pagesLTS.pagenr}}{\@showPageThreshold}{\thepage}{}}
\newbool{showPage}
\setbool{showPage}{true} % Default to showing page numbers
\def\showPageNumbers{\setbool{showPage}{true}}
\def\hidePageNumbers{\setbool{showPage}{false}}
\newcommand{\@checkPageVal}{\ifnumgreater{\value{pagesLTS.pagenr}}{\@showPageThreshold}{\showPageNumbers}{\hidePageNumbers}}

% Define the command to hide the revised date
\def \hideRevisedDate{\def \@rRevisedDate{} \setbool{showRevisedDate}{false}}
\def \@rRevisedDate {\textit{Revised \filemodprintdate{\jobname}}}

\def \@lfootval{%
  \@checkPageVal%
  \ifboolexpr{bool{footerNameDefd} and ( bool{showRevisedDate} or bool{showPage} )}{%
    % Footer name is defined an either the revised date or the page number
    \@footername%
  }{%
    \ifboolexpr{ bool{showRevisedDate} and bool{showPage}}{%
      \@rRevisedDate%
    }{}%
  }%
}

\def \@cfootval{%
  \@checkPageVal%
  \ifboolexpr{bool{showPage} and not ( bool{footerNameDefd} or bool{showRevisedDate} )}{%
    % Only the page number is defined
    \@rPageVal%
  }{%
  \ifboolexpr{bool{footerNameDefd} and not ( bool{showRevisedDate} or bool{showPage} )}{%
    % Only the footer name is defined
    \@footername%
  }{%
  \ifboolexpr{bool{showRevisedDate} and (%
        ( bool{footerNameDefd} and bool{showPage} ) or%
        ( not ( bool{footerNameDefd} or bool{showPage} )))}{%
    \@rRevisedDate%
  }{}%
  }%
  }%
}

\def \@rfootval{%
  \@checkPageVal%
  \ifboolexpr{bool{showPage} and ( bool{footerNameDefd} or bool{showRevisedDate} )}{%
    % Page number is defined and either the footer name or the revised date
    \@rPageVal%
  }{%
    \ifboolexpr{bool{footerNameDefd} and bool{showRevisedDate}}{%
      % Only the footer name and the revised date are defined
      \@rRevisedDate%
    }{}%
  }%
}

\lfoot{\scriptsize \@lfootval}
\cfoot{\scriptsize \@cfootval}
\rfoot{\scriptsize \@rfootval}


%----------------------------------------------------------------------------------------
% Other custom stuff
%----------------------------------------------------------------------------------------

% The \threecol command makes three paragraph boxes of equal size and places them on the same line
\newcommand{\threecol}[3]{%
\parbox{.333\linewidth}{#1\hfill}%
\parbox{.333\linewidth}{\hfil#2\hfil}%
\parbox{.333\linewidth}{\hfill#3}%
}

\endinput
