# Resume & CV Template/Example

This template is based on the `resume.cls` class first created by [Trey Hunner](http://www.treyhunner.com/), then
modified and posted on [LaTeX Templates](http://www.latextemplates.com/template/medium-length-professional-cv). Key
modifications to the original template include:

* Reordering of the fields for experience entries so that the position title and date are on the first line and the
  organization and location are on the second line. (See also issues #12 and #13.)
* Ability to specify a "logo" which appears in the upper right-hand corner of the document.
* Separation, renaming of sections to allow more flexibility in the document layout.
* Introduction of footers that show the date the document was revised, page number (for documents >2 pages long), and
  a name (such as a last name).
* Improvement of margins and spacing to improve readability and minimize content breaking between pages when it
  shouldn't.
* A personalized bibliography for researchers with published work they want to showcase, and a way to divide the
  publications into groups.
* Flags for specifying that the document is a CV (which usually has way more content than a resume), allowing for
  dynamic content inclusion. With this, a resume and a CV can be produced from the same source files, reducing the
  amount of work necessary to keep the two current with each other.
* So much more!

**Table of Contents:**

[TOC]

## Getting Started

I recommend cloning only the `template` branch by using git's `--single-branch` option:

```
git clone git@bitbucket.org:mmabey/resume.git --single-branch --branch template
```

Or, for HTTP cloning:

```
git clone https://mmabey@bitbucket.org/mmabey/resume.git --single-branch --branch template
```

To use the template, the only files you really need are:

* [resume.cls](resume.cls): Provides the `resume` document type so you can do `\documentclass{resume}`.
* [biblatex.cfg](biblatex.cfg): Configuration file for BibLaTeX, which defines how publications are listed. BibLaTeX was
  the best option I could find for creating multiple bibliographies with a customized prefix to the reference numbers.
  **Note**: BibLaTeX is very different from [BibTeX](https://en.wikipedia.org/wiki/BibTeX), which is the default on most
  LaTeX installations, so if you haven't used it before it might do you some good to read up on the
  [documentation](http://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf).
* [Makefile](Makefile): While not strictly required, the functions it has may be useful, particularly the `resume`,
  `cv`, and `clean` targets. The first two will compile files matching `Resume_*.tex` and `CV_*.tex`, respectively. The
  `clean` target should remove all the files that LaTeX creates when compiling your document. To run the targets on the
  command line, run `make cv`, `make resume`, or `make clean`. You'll need to have `make` installed.


Beyond that, you're welcome to use or not use any of the files as a guide for bringing everything together. I hope it
goes without saying that I don't give my permission to copy the *content* to your own resume/CV.

I've found that it's helpful to have all of the content of my resume and CV in distinct files so I can reference (with
`\input{}`) each of them separately as needed. This allows me to update the content once and have it reflected in both
documents (resume and CV). Hence, I have both a `CV_*.tex` file and a `Resume_*.tex` file. (I discuss how to switch
content on and off for the two types of documents below under [Flags](#markdown-header-flags).)

Taking this a step further, I also created different layouts for when I need a CV with a different emphasis (order of
sections).



### Basic Setup

Here are the things you must do if creating a document from scratch.

Just like any other LaTeX document, you must first set up the class of the document by pointing to the `.cls` file you're using, which is `resume.cls` in this instance:

```
#!latex
\documentclass{resume}
```

Here's where you want to do any other package importing using the `\usepackage{}` command. If you don't use the [`font`
option](#markdown-header-font), this is also where you'll want to set up the font you want (see the [LaTeX Font
Catalogue](http://www.tug.dk/FontCatalogue/) for options).

The next thing you want to do is set up the document heading to display your name, contact info, etc. Here's how I set
this up:

```
#!latex
\name{Michael K. Mabey}
\footername*{Mabey}
\address{(480)\,788--3411 \\ \href{mailto:mmabey@asu.edu}{mmabey@asu.edu} \\ \href{http://mikemabey.com}{mikemabey.com}}
```
The above renders as:

![Example heading][headingExample]

For detailed information about each of these commands, see the [Document Heading
Commands](#markdown-header-document-heading-commands) and [Changing the Footers](#markdown-header-changing-the-footers)
sections.


If you plan to add a set of publications to your document, there's one final thing you should do in the preamble: add
the `.bib` file as a bibliography resource, like this:
```
#!latex
\addbibresource{pubs_mike_mabey.bib}
```

This is one way that BibLaTeX differs from BibTeX, which is that you are required to declare the bibliography resource
files in the preamble (before the `\begin{document}` command). I discuss some other differences under [Creating a
Bibliography](#markdown-header-creating-a-bibliography).


At this point, you can now add the `\begin{document}` command and start declaring different environments as explained
[below](#markdown-header-environments).


### Class Options

When you call the `resume` document class, you can specify a number of options as described below. All of these options
can be combined, except where they would obviously conflict (because they change the same element(s) of the document.)

#### `margins`

Giving the `margins` option sets the margins on all four sides of the documents. If you show content in the
[footer](#markdown-header-changing-the-footers), be careful that you don't make the margins so small that the content
pushes the footer off the page. Below is an example of how to use this class option:

```
#!latex
\documentclass[margins=0.75in]{resume}
```

The default for all margins is `0.75in`.


#### `vmargins` and `hmargins`

The `vmargins` and `hmargins` options set the vertical and horizontal margins, respectively. If you show content in the
[footer](#markdown-header-changing-the-footers), be careful that you don't make the margins so small that the content
pushes the footer off the page. Below are examples of how to use these class options:

```
#!latex
\documentclass[vmargins=0.5in]{resume}
\documentclass[hmargins=1in]{resume}
```

These set a vertical margin of `0.5in` and a horizontal margin of `1in`. The default for all margins is `0.75in`, set by
the [`margins`](#markdown-header-margins) option.


#### `font`

Use the `font` option to specify which font you want the document to have. The following fonts are currently supported:

* [Bera Sans](http://www.tug.dk/FontCatalogue/berasans/) - Use: `[font=berasans]`
* [Cantarell](http://www.tug.dk/FontCatalogue/cantarell/) - Use: `[font=cantarell]`
* [Computer Modern](http://www.tug.dk/FontCatalogue/computermodernsansserif/) - Use: `[font=computermodern]` --- this is the default font if no other valid option is provided
* [Lato](http://www.tug.dk/FontCatalogue/lato/) - Use: `[font=lato]`
* [Quattrocento Sans](http://www.tug.dk/FontCatalogue/quattrocentosans/) - Use: `[font=quattrocento]`
* [Source Sans Pro](http://www.tug.dk/FontCatalogue/sourcesanspro/) - Use: `[font=sourcesanspro]`

These are the fonts from the [LaTeX Font Catalogue](http://www.tug.dk/FontCatalogue/) that I found professional-looking
and were in the Sans Serif family. The latter criterion was important to me because I wanted my resume/CV to be more
tailored for screen viewing.

If you want to use a font *NOT* listed above, use the option `[font=none]`, and not even the default font will load,
allowing you to set up your own font from the catalogue.


#### `cvmode`

The `cvmode` option can be set with a value of either `true` or `false` (case sensitive). Actually, anything other than
`false` will evaluate to `true`, including just `[cvmode]`. This may be a more convenient way of switching between
[resume and CV modes](#markdown-header-resume-vs-cv). Below is an example of how to use this class option:

```
#!latex
\documentclass[cvmode=FALSE]{resume}
```

The default for `cvmode` is `true`.


#### `linkicon`

The `linkicon` option can be set with a value of either `true` or `false` (case sensitive). Actually, anything other
than `false` will evaluate to `true`, including just `[linkicon]`. Setting it to `true` adds a small icon next to any
links in the document created with the `\href{}{}` command (from the `hyperref` package). This just gives the reader a
visual cue that the text is click-able, when they otherwise might not know it was a link.

Here's an example of a URL with the icon:

![Example of `linkicon` set to true][linkicon_trueExample]

... and another without the icon:

![Example of `linkicon` set to false][linkicon_falseExample]


#### `pagethreshold`

The value passed to the `pagethreshold` option determines when page numbers appear in the document footer. The default
value is 2, which means that there must be *more* than 2 pages in the document to have numbered pages. Hopefully it also
goes without saying that the value must be an integer. If not, the default value will be used.


#### `icon` and `iconsize`

As an alternate to the `\icon` macro (see the section on [that command](#markdown-header-icon)), you can specify the
icon file and its size as options to the document class. Here's an example of how you might use them:

```
#!latex
\documentclass[icon=figs/icon.png, iconsize=0.5in]{resume}
```

Attempting to compile with only one of these options and not both will result in an error. Also, the value for
`iconsize` **must** be a dimension, not just a number.


#### `showreviseddate`

If you want to explicitly set whether the "Revised" date appears in the footer (see the section on
[footers](#markdown-header-changing-the-footers) for more information), you can call this class option, setting it to
`true` or `false`. If no `true`/`false` parameter is given, it will default to `true`, showing the date.


#### `lastname`

If you want to set your last name for matching entries in bibliographies using the class options instead of the other
command (see the section on the [`\MyLastName` command](#markdown-header-mylastname) for more information), use the
`lastname` option, setting it to your last name.

**Note**: If you just call this option without a value, it will have no effect.


#### `footername`

If you want to set the name that appears in the footer by using the class options instead of the other command (see the
section on [Changing the Footers](#markdown-header-changing-the-footers) for more information), use the `footername`
option, setting it to the value you want.

**Note**: If you just call this option without a value, it will have no effect.




## Environments

Environments are the sections of LaTeX that use the `\begin{}` and `\end{}` commands. Most of the environments provided
begin with "r" as a reminder that they're part of this resume class.

### `rSection`

The `rSection` environment is meant to signify a major section in the document, such as "Education" or "Experience". The
title of the section is always converted to all caps, bolded, and followed by a horizontal rule.

```
#!latex

\begin{rSection}{Professional Experience}
\end{rSection}
```
The above renders as:

![Example of `rSection`][rSectionExample]

At the technical level, the `rSection` environment creates a `rSectionHeading`, and then begins an environment that
simply adds a `1.5em` margin on the left side for aesthetics.

The `rSection` environment also allows you to give `titleOnly` as a parameter, which will turn on the `titleOnly` global
flag. This is a shortcut that allows you to write something like this:
```
#!latex
\begin{rSection}[titleOnly]{Section Heading}

  % Section content here...

\end{rSection}
```
instead of this:
```
#!latex
\begin{rSection}{Section Heading}
  \setboolean{titleOnly}{true}

  % Section content here...

  \setboolean{titleOnly}{false}
\end{rSection}
```

See the section on the [`rExperience`](#markdown-header-rexperience) environment for more examples using this flag.



### `rSectionHeading`

The `rSectionHeading` environment is what formats the header for the `rSection` environment. This comes in handy when
you want a new section, but don't want the extra formatting and margins created by the `rSection` environment. It
renders very similarly to the example given in the section above on `rSection`.



### `rBulletList`

The `rBulletList` environment is the principal way to list items in the document. It handles a number of spacing,
layout, and style considerations to simplify and unify itemized lists. There are three ways to use a `rBulletList`:

1. Basic usage
2. Multi-column
3. Nested

The most basic use of a `rBulletList` environment is something like this:
```
#!latex

\begin{rBulletList}
  \item CSE 465 Information Assurance with Dr.\ Gail-Joon Ahn: Fall 2010, Fall 2015.
  \item CSE 469 Computer and Network Forensics with Dr.\ Gail-Joon Ahn: Spring 2015.
  \item FSE 100 Introduction to Engineering with Dr.\ Ryan Meuth: Spring 2014.
  \item CSE 423/424 Capstone I and CSE 485/486 Capstone II with Dr.\ Debra Calliss: Spring 2014.
  \item CSE 467 Data \& Information Security with Dr.\ Gail-Joon Ahn: Spring 2011.
\end{rBulletList}
```
Which renders as:

![Simple example of `rBulletList`][rBulletListExampleSingle]


Many times it is necessary to have a multi-column list. To do this, add a parameter specifying how many columns you
need. To keep the columns even, you may need to add one or more empty items at the end with `\item[]`.
```
#!latex

\begin{rBulletList}[2]
  \item Computer and Network Forensics
  \item Advanced Topics in Digital Forensics
  \item Information Assurance
  \item Security Toolkit Programming with Python
  \item Cryptography
  \item Software Security
  %\item[]  % Uncomment as necessary to make the items even out
\end{rBulletList}
```
The above renders as:

![Example of a multi-column `rBulletList`][rBulletListExampleMulticol]


If you need to have a list nested within another list, `rBulletList` will alternate the bullet symbol between a small
dot (on odd-level lists, e.g. first level, third level, etc.) and a small white circle (on even-level lists). For
example:
```
#!latex

\begin{rBulletList}
  \item Student Program Committee Member:
    \begin{rBulletList}
      \item IEEE Security \& Privacy \hfill \emph{2016}
    \end{rBulletList}
  \item Conference Proceedings Subreviewer:
    \begin{rBulletList}
      \item ACM CODASPY \hfill \emph{2013, 2014, 2015, 2016}
      \item SACMAT \hfill \emph{2014}
      \item ASIACCS \hfill \emph{2014}
    \end{rBulletList}
  \item Student Volunteer:
    \begin{rBulletList}
      \item ACM CCS \hfill \emph{2014}
    \end{rBulletList}
\end{rBulletList}
```
Which renders as:

![Example of nested `rBulletList`][rBulletListExampleNested]



### `rBulletSection`

For those times when the only content you need is a bulleted list in a section, the `rBulletSection` is the best option.
Like the `rBulletList` environment, it allows for multiple columns but defaults to using just one column. As an example
that uses multiple columns:
```
#!latex

\begin{rBulletSection}[2]{Teaching Interests}
  \item Computer and Network Forensics
  \item Advanced Topics in Digital Forensics
  \item Information Assurance
  \item Security Toolkit Programming with Python
  \item Cryptography
  \item Software Security
\end{rBulletSection}
```
The above renders as:

![Example of `rBulletSection`][rBulletSectionExample]

At the technical level, the `rBulletSection` environment creates a `rSection` environment and then a `rBulletList`
inside that, but with the added benefit of handling the vertical space between the horizontal rule (from the `rSection`
header) and the first bullet. This space varies depending on the number of columns specified, but it is unified by the
`rBulletSection` environment code.



### `rBulletSubsection`

The `rBulletSubsection` environment is useful when you need to sub-divide the contents of a `rSection` environment with
formatting different from a `rExperienceHeader` or `rExperienceBullets` environment. The subsection title is bolded, but
not capitalized, and no horizontal rule is inserted. For example:
```
#!latex

\begin{rSection}{Service}
  \begin{rBulletSubsection}{Department}
    \item Team Leader: ASU team in the UCSB International CTF \hfill \emph{2009, 2010, 2014, 2015}
    \item Panelist: PhD Open House Student Panel \hfill \emph{Feb 2014, Feb 2015}
  \end{rBulletSubsection}
\end{rSection}
```
The above renders as:

![Example of `rBulletSubsection`][rBulletSubsectionExample]



### `rExperience`

The `rExperience` environment displays the four key pieces of information related to job experience:

1. The job title
2. The organization the job was with
3. The month and year the job started and ended
4. The location of the organization

#### Specifying the Fields

You can specify experience information in two different ways. The first way is to pass all four fields in as parameters
as shown in the examples a little lower down. The second way is to set the fields before beginning the `rExperience`
environment so you don't have to pass them as arguments (see #14). Here's an example of the second way:
```
#!latex
\expPosTitle{Head Boss of Everyone}
\expPosPeriod{Jan 1999 -- Dec 1999} % Start and end dates
\expOrgName{Santa's Workshop}
\expOrgLoc{North Pole, AK}

\begin{rExperience}
  \item Experience description goes here
\end{rExperience}
```

When LaTeX prints the environment, it will pull from the variables set by the `\expPos...` and `\expOrg...` commands to
fill in the necessary information. This is simply provided as a convenience (and to enable forward-compatibility with
the fix for issue #13). You can still give the four parameters directly to the command in the order you want them to
appear (see issue #12). In other words, the first field you pass to the `\begin{rExperience}` command will go in the
top-left position, the next will go in the top-right position, and so on.

#### Adding Extra Content

You can also add more information to the experience header by calling the `\expExtra{}` command with the content that
should appear after the four standard headers. For example:
```
#!latex
\expPosTitle{Research Assistant}
\expPosPeriod{Nov 2009 -- Present}
\expOrgName{SEFCOM}
\expOrgLoc{Tempe, AZ}
\expExtra{\textit{Lab Directors}: Gail-Joon Ahn, Adam Doup\'{e}\\
  \textit{Sponsors}: Department of Energy, National Science Foundation}

\begin{rExperienceHeader}
\end{rExperienceHeader}
```
The above renders as:

![Example of adding extra content that appears after the usual `rExperience` fields][rExperienceHeaderExample]

#### Customizing the Fields

You can customize the order that the four fields appear, to a limited degree (issue #12). To do this, add a line like
the following to the document's preamble:
```
#!latex
\setExpOrder{tpnl}
```

The letters passed to the command refer to the four fields displayed by the experience header. The available options for
the `\setExpOrder{}` command are:

* `tpnl`: Job title, period of the experience, organization's name, organization's location *(Default)*
* `tlnp`: Job title, location, organization's name, period of the experience
* `nltp`: Organization's name, location, job title, period of the experience
* `nptl`: Organization's name, period of the experience, job title, location. This is the order that was used in Trey Hunner's original template

You can also customize the style used on each field (e.g. bold, italic, normal) according to the field's position
(top-left, bottom-right, etc.). The default styles are:

* **Top-Left**: Bold, using the `\bf` command
* **Top-Right**: Italic, using the `\em` command
* **Bottom-Left**: Plain, using the `\textnormal` command
* **Bottom-Right**: Plain, using the `\textnormal` command

To change these, call the following commands, passing the format command as a parameter:

* `\setExpStyleTL{}`: Changes the top-left field's style
* `\setExpStyleTR{}`: Changes the top-right field's style
* `\setExpStyleBL{}`: Changes the bottom-left field's style
* `\setExpStyleBR{}`: Changes the bottom-right field's style

The defaults are set with calls equivalent to the following:
```
#!latex
\setExpStyleTL{\bf}
\setExpStyleTR{\em}
\setExpStyleBL{\textnormal}
\setExpStyleBR{\textnormal}
```

If you're interested in more technical details, the parameter you pass when setting a new style must be a command or
macro that requires no arguments (rather than an environment) because the style is ultimately stored by using TeX's
`\let` command, which essentially makes a copy of a command at the point where `\let` is called. For more information on
`\let`, I recommend [this post on
StackExchange](http://tex.stackexchange.com/questions/258/what-is-the-difference-between-let-and-def).


#### Switching Content with `titleOnly`

The `rExperience` environment intelligently switches between showing the `rExperienceHeader` and `rExperienceBullets`
environments based on the status of the `titleOnly` flag. If the flag is true, a `rExperienceHeader` is shown with no
body text. If it is false, a `rExperienceBullets` environment is shown along with all the text inside the
`\begin{rExperience}` and `\end{rExperience}` commands.

The purpose of this environment is to allow for an "experience summary" section that simply lists the various positions
with their associated organizations, locations, and date ranges, but without the explanation of what the job entailed.
The benefit of using this environment is that you can put the details about a single job experience in one place,
keeping dates and other information consistent.

**Note**: The default value of the `titleOnly` flag is false.

As an example, here is a `rExperience` environment that sets the `titleOnly` flag to true:

```
#!latex

\begin{rSection}[titleOnly]{Experience Summary}
  \begin{rExperience}{Teaching Assistant}{Aug 2010 -- Dec 2015}{Arizona State University}{Tempe, AZ}

    \item More explanation of experience here

  \end{rExperience}

  \begin{rExperience}{SAT/ACT Instructor}{Sep 2015 -- Oct 2015}{Minerva Learning, LLC}{Chandler, AZ}

    \item Tutoring experience explained here

  \end{rExperience}
\end{rSection}
```
The above renders as:

![Example of `rExperience` with `titleOnly` set to true][rExperienceExample_titleOnly]

But when the `titleOnly` flag is removed (which defaults to false), like so:

```
#!latex

\begin{rSection}{Experience Detail} % <--- No titleOnly flag specified
  \begin{rExperience}{Teaching Assistant}{Aug 2010 -- Dec 2015}{Arizona State University}{Tempe, AZ}

    \item More explanation of experience here

  \end{rExperience}

  \begin{rExperience}{SAT/ACT Instructor}{Sep 2015 -- Oct 2015}{Minerva Learning, LLC}{Chandler, AZ}

    \item Tutoring experience explained here

  \end{rExperience}
\end{rSection}
```
then it renders like this:

![Example of `rExperience` with `titleOnly` set to false][rExperienceExample]



### `rExperienceHeader`

The `rExperienceHeader` environment displays the four key pieces of information related to job experience:

1. The job title
2. The organization the job was with
3. The month and year the job started and ended
4. The location of the organization

**Note**: You typically won't need to use the `rExperienceHeader` environment directly, since the `rExperience`
environment does exactly what the `rExperienceHeader` environment does, but with the ability to switch between
`rExperienceBullets` and `rExperienceHeader` as necessary (given the state of the `titleOnly` flag).



### `rExperienceBullets`

The purpose of the `rExperienceBullets` environment is to provide a convenient way to write about your experience in a
bulleted format. In addition to printing the position, title, and other information about your experience (it uses the
`rExperienceHeader` environment to do this), it begins a `rBulletList` environment so you can give each bullet with the
`\item` command. Here's a simple example:

```
#!latex

\begin{rExperienceBullets}{SAT/ACT Instructor}{Sep 2015 -- Oct 2015}{Minerva Learning, LLC}{Chandler, AZ}
  \item Individual tutor for a high school student preparing for the PSAT.
\end{rExperienceBullets}
```
The above renders as:

![Example of the `rExperienceBullets` environment][rExperienceBulletsExample]

**Note**: You typically won't need to use the `rExperienceBullets` environment directly, since the `rExperience`
environment does exactly what the `rExperienceBullets` environment does, but with the ability to switch between
`rExperienceBullets` and `rExperienceHeader` as necessary (given the state of the `titleOnly` flag).



### `CVonly`

See [Flags](#markdown-header-flags) below.

### `ResumeOnly`

See [Flags](#markdown-header-flags) below.






## Flags

### `titleOnly`

As mentioned previously, the [`rSection`](#markdown-header-rsection) environment uses a global flag called `titleOnly`
to determine when to skip displaying the body of the `rSection` environment. You shouldn't ever have to access or modify
this flag directly, but if you need to, you can do so like this:
```
#!latex
\ifthenelse{\boolean{titleOnly}}{do this if true}{do this if false}
```

**Note**: The `titleOnly` flag defaults to `false` and should be reset to have a value of `false` after you're done in a
section where you needed it to be `true`.


### Resume vs. CV

With the `resume.cls` class, you can switch content on and off based on whether you're building a resume or a CV, the
idea being that CVs are more verbose that resumes, so there's likely content that you don't want to show in one or the
other. Using this feature, you can have one set of information to maintain but be able to build two different document
types.

#### `isCV`, `\isCV`, and `\setNotCV`

There is a flag defined in the class file that defaults to `true`, indicating that the document type is a CV. This flag
is called `isCV`. You can use it directly by doing something like the following:
```
#!latex
\ifthenelse{\boolean{isCV}}{do this if true}{do this if false}
```

There's also a shortcut version of the above, the `\isCV{}` macro. This is how you use it:
```
#!latex
\ifthenelse{\isCV{}}{do this if true}{do this if false}
```

Since the flag default to `true`, if you want to set the flag to false, one call to the `\setNotCV{}` macro will switch this flag, along with some other minor settings just for resumes.


#### `isCV` Shortcuts

There are four shortcuts for switching content on and off based on the `isCV` flag. Two are commands and two are
environments. The `CVonly` and `ResumeOnly` environments work like other environments and require a `\begin` and `\end`.
Intuitively, the contents of the environment will only appear if the `isCV` flag is `true` or `false`, respectively.
Here are some examples:

```
#!latex
\begin{CVonly}
  This will only appear in a CV.
\end{CVonly}
```
```
#!latex
\begin{ResumeOnly}
  This will only appear in a resume.
\end{ResumeOnly}
```

The `\rCVonly{}` and `\rResumeOnly{}` command shortcuts work just like the environments do, but provide a different
syntax structure for switching the content on and off. Here are the equivalent versions of the examples above:

```
#!latex
\rCVonly{This will only appear in a CV.}
```
```
#!latex
\rResumeOnly{This will only appear in a resume.}
```






## Commands and Macros

### Document Heading Commands

#### `\name`

As shown in [Getting Started](#markdown-header-getting-started), setting `\name{}` will display your name at the top
center of the document with a font size of [`\huge{}`](https://en.wikibooks.org/wiki/LaTeX/Fonts#Sizing_text). If you
want to change the size of your name, change the definition of the `\namesize` macro. If you want to change anything
else about how your name appears, redefine the `\printname` macro.


#### `\namesize`

You shouldn't have to change this macro unless you have a problem with the size of the name at the top of the document.
The original definition is simple:
```
#!latex
\def\namesize{\huge} % Size of the name at the top of the document
```


#### `\printname`

Under normal circumstances, you won't have to call this macro. When you do the typical `\begin{document}` command,
`\printname` will automatically be called. Similarly, you shouldn't have to change the definition of the macro unless
you dislike some aspect of how the name is displayed. Here is the original definition:
```
#!latex
\def \printname {
  \begingroup
    \hfil{\namesize\bf \@name}\hfil
    \nameskip\break
  \endgroup
}
```


#### `\address`

The `\address{}` sets your contact information so it can be displayed after your name. The `\\` macro has been redefined
for addresses to be a diamond-shaped separator (see [`\addressSep`](#markdown-header-addresssep) for more detail).
Everything inside the `\address{}` command will appear on the same line. To add another line, use an additional
`\address{}` command. You can have up to three lines using this method.


#### `\printaddress`

Just like `\printname`, you won't have to call this macro under normal circumstances because `\begin{document}` already calls it. Here is the original definition:
```
#!latex
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}
```


#### `\addressSep`

This macro defines the separator between discreet items in the `\address{}` command. The default is a diamond, but you
can change this by redefining the macro. Here is the original definition:
```
#!latex
\def \addressSep {$\diamond$} % Set default address separator to a diamond
```


#### `\icon`

I originally created this macro to display a QR code in the top right corner that links to my LinkedIn account. It takes
two parameters: (1) the width that the image should have, and (2) the path to the icon image.


#### `\printicon`

Just like `\printname` and `\printaddress`, you won't have to call this macro under normal circumstances because
`\begin{document}` already calls it.



### Spacing and Formatting

#### Skips

The following skips are defined to allow more convenient changes to some of the skips that appear in a document. You
should only have to redefine these macros if you're unhappy with the amount of space between different types of content.

* `\sectionskip`
* `\sectionlineskip`
* `\nameskip`
* `\addressskip`
* `\bibheadingskip`
* `\bibpostskip`

Here are the original definitions for these skips:
```
#!latex
\def\sectionskip{\smallskip} % The space after the heading section
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section
\def\nameskip{\medskip} % The space after your name at the top
\def\addressskip{} % The space between the two address (or phone/email) lines
\def\bibheadingskip{\vspace{-2\parskip}} % The space after the bib heading and before the first entry
\def\bibpostskip{\vspace{-4\parskip}} % The space at the end of the bibliography before any other content
```


#### Reserved Space

The `needspace` package allows you to reserve a certain amount of space before printing any more content. What this does
is tells the LaTeX compiler that if there is not at least the specified amount of space remaining on the page to put the
next content on a new page. This is the simplest way I could find to keep section headings with their content and that
sort of thing. These are the defined spaces:

* `\secHeadSpace` - For section headings, to keep them with the contents of the section.
* `\subsecSpace` - For subsection headings.
* `\expHeaderSpace` - For experience headings.
* `\bibSpace` - For bibliography titles, to keep them together with their publications.

Their original definitions are:
```
#!latex
\def\secHeadSpace{7\baselineskip}
\def\subsecSpace{2\baselineskip}
\def\expHeaderSpace{3\baselineskip}
\def\bibSpace{3\baselineskip}
```

The length of a `\baselineskip` is equal to the height of the text in a line plus the spacing between one line and the
next. So, `{2\baselineskip}` is the amount of vertical space taken by two lines of text plus any spacing around them.

I'm not sure why it is necessary to have so much space reserved for section headings, but I've had issues when I use a
multiplier of less than 7.


#### Other Formatting

To change the symbols used in the `rBulletList` environment, redefine the `\rBulletSymbolOdd` and `\rBulletSymbolEven`
macros. Here are there original definitions:
```
#!latex
\def\rBulletSymbolOdd{$\cdot$}
\def\rBulletSymbolEven{$\vysmwhtcircle$}
```



## Creating a Bibliography

I like to add a list of publications to my resume. When I first started working on my CV, I wanted a way to separate my
publications by type of venue, e.g. conference, journal, etc. I also wanted to be able to add a prefix to each entry
that also indicated the type of venue so I could reference the paper in other parts of the CV. For example, a
publication at a conference should have the prefix "C" so it would appear as [C1] in the list of publications and in any
references to it elsewhere.

While there are solutions that satisfy one or the other of my requirements, the only thing that allowed me to do both
was switching from the default BibTeX to BibLaTeX. While in certain circumstances it might make sense to just use the
commands provided natively by BibLaTeX, I made a custom command for printing a bibliography so it would be easier to
unify the appearance and the spacing every time.

If you want to customize/change the appearance of the bibliography, the two places you can do that are (1) in the
definition of the `\mybibliography` command, and (2) in the `biblatex.cfg` file. Consult the documentation on
[BibLaTeX](http://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf) for details.

**Note**: As discussed in the [Basic Setup](#markdown-header-basic-setup) section, you need to include a call to
`\addbibresource`in the preamble, i.e. before you call `\begin{document}`.


### `\mybibliography`

The `\mybibliography` command takes exactly three arguments:

1. The title for the list of publications, e.g. "Peer-Reviewed Conference Proceedings"
2. The reference prefix, e.g. "C"
3. A keyword for filtering entries from the `.bib` file, e.g. "conference"

The third argument, the keyword, must match exactly the entries you want to appear in this list of publications. In the
`.bib` file, use the `Keywords` field for this. The following example has the "conference" and "major" keywords properly
added:
```
@InProceedings{Paglierani2013,
  Title                    = {Towards Comprehensive and Collaborative Forensics on Email Evidence},
  Author                   = {Paglierani, Justin and Mike Mabey and Ahn, Gail-Joon},
  Booktitle                = {Collaborative Computing: Networking, Applications and Worksharing (Collaboratecom), 2013 9th International Conference Conference on},
  Year                     = {2013},
  Month                    = oct,
  Pages                    = {11-20},

  Doi                      = {10.4108/icst.collaboratecom.2013.254125},
  Keywords                 = {conference,major}
}
```

You can have whatever keywords you want as part of an entry, as long as they are comma-delimited and match the case you
use in your call to `\mybibliography` (e.g. all lowercase). The reason I include the "major" keyword is because that's
the keyword I use to filter the publications I want to appear on my resume, which has a selected list of publications.

Using the example fields above, a call to `\mybibliography` would look like this:
```
#!latex
\mybibliography{Peer-Reviewed Conference Proceedings}{C}{conference}
```
The above renders like this:

![Example of `\mybibliography` displaying conference papers][mybibExample]



### `\MyLastName`

Another good thing to do with a list of publications is to accentuate your name in some way, so that people reviewing
your resume/CV can pick you out in the list of authors more easily. To do this, make a call to the `\MyLastName` macro
sometime before you call `\mybibliography` (I do it along with setting my name and contact info). Here's an example:
```
#!latex
\def\MyLastName{Mabey}
```

You can see the result in the example given above for `\mybibliography`. Every time my name appears in the list of
authors it is wrapped with a `\textbf{}` command. If you want to change how your name is accentuated, you'll need to
change the code in `biblatex.cfg` under `\renewbibmacro*{name:first-last}`.



## Changing the Footers

By default there are a few fields used to populate the footer of the document. The table below shows the default
settings for showing the footer fields. The fields spread themselves out so they are balanced. In other words, if the
page number has been suppressed, the revised date will be repositioned to the right side so the footer doesn't feel
right-heavy.

Field        | CV         |  Resume   | Position
-------------|------------|-----------| ------------------
Footer name  | If set     | If set    | Left or Center
Revised date | Yes        | Yes       | Center if possible
Page #       | If > 2 pgs | Not shown | Center or Right


To change the footer name, use the `\footername{}` and `\footername*{}` commands. The starred version will only show the
footer name if `isCV` is set. I set this field to my last name so people reviewing my CV will have a little reminder of
whose CV they're looking at.

To explicitly turn on or off page numbers, use the `\showPageNumbers` and `\hidePageNumbers` macros, respectively. When
`isCV` is set, page numbers will only be displayed if there are at least 2 pages in the document. To change this
threshold, use the `\setShowPageThreshold{}` macro.

The revised date is always on by default. To turn it off, make a call to the `\hideRevisedDate` macro.




## Required Packages

As the sophistication of the class increased, so did the number of additional packages it used. Here is a
(non-exhaustive) list of the packages required for this class:

* array
* biblatex
* environ
* etoolbox
* expl3
* fancyhdr
* filemod
* fontawesome
* fontenc
* geometry
* graphicx
* hyperref
* microtype
* multicol
* needspace
* pageslts
* quoting
* scrextend
* stix
* suffix
* wrapfig
* xkeyval
* xparse
* xstring


**Note**: All these packages are a part of [TeXLive](https://en.wikipedia.org/wiki/TeX_Live).





[rSectionExample]: docs/rSectionExample.png
[rBulletSubsectionExample]: docs/rBulletSubsectionExample.png
[rBulletListExampleSingle]: docs/rBulletListExampleSingle.png
[rBulletListExampleMulticol]: docs/rBulletListExampleMulticol.png
[rBulletListExampleNested]: docs/rBulletListExampleNested.png
[rBulletSectionExample]: docs/rBulletSectionExample.png
[rExperienceExample_titleOnly]: docs/rExperienceExample_titleOnly.png
[rExperienceExample]: docs/rExperienceExample.png
[rExperienceHeaderExample]: docs/rExperienceHeaderExample.png
[rExperienceBulletsExample]: docs/rExperienceBulletsExample.png
[headingExample]: docs/headingExample.png
[mybibExample]: docs/mybibExample.png
[linkicon_trueExample]: docs/linkicon_trueExample.png
[linkicon_falseExample]: docs/linkicon_falseExample.png
