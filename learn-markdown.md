## [Markdown学习](https://www.markdowntutorial.com/lesson/1/)

### italics bold monospace
- italic, surround words with an underscore ( _ ). 
    - eg. _good_
- bold, surround words with two asterisks ( ** ). 
    - eg. **bold**
- italic and bold,either is ok 
    - eg. **_both_** , _**both**_
- highlight with monospace
    - `mono`

### header
- Preface the phrase with a hash mark (#). 
- You place the same number of hash marks as the size of the header you want. header one = # Header One
### link
- brackets ( [ ] ), and then wrap the link in parentheses ( ( ) ) 
    - eg. You can [search for it](www.google.com) on the website.
- make links within headings 
    - eg. The line is Header four and add links to the BBC
        - #### The Latest News from [the BBC](www.bbc.com/news) 
### images
- inline image link: an exclamation point ( ! ), wrap the alt text in brackets ( [ ] ), and then wrap the link in parentheses ( ( ) )
    - eg. ![A pretty tiger](https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg)
- reference image: an exclamation point, then provide two brackets for the alt text, and then two more for the image tag, like this: ![The founding father][Father]. And at the bottom of your Markdown page, you'll define an image for the tag, like this: [Father]: http://octodex.github.com/images/founding-father.jpg
    - eg. 
    ![Black cat][Black]    
    ![Orange cat][Orange]

    [Black]: https://upload.wikimedia.org/wikipedia/commons/a/a3/81_INF_DIV_SSI.jpg

    [Orange]: http://icons.iconarchive.com/icons/google/noto-emoji-animals-nature/256/22221-cat-icon.png
### blockquotes
- blockquote: preface a line with the "greater than" caret (>) eg. 
    >In a few moments he was barefoot
- quote spans multiple paragraphs：blank lines must contain the caret character. eg.
    > His words seemed to have struck some deep chord in his own nature. Had he spoken
    >
    > —Of whom are you speaking? Stephen asked at length.
    >
    > Cranly did not answer.
### lists
- unordered list: preface with an asterisk ( * ) (- + also work) and a space
    eg. 
    * a  
    * b
        + c     (# to add some sub-list, indent each asterisk one space more than the preceding item)
            - d
- ordered list：with numbers
    eg. 
    1. a
    2. b
    3. c
### paragraphs
- hard break(not recommended): to forcefully insert a new line by inserting a blank line  
    eg. 
    
    Do I contradict myself?

    Very well then I contradict myself,
- soft break: each line end up with two space and then start a new line.
    eg.   
    Do I contradict myself?  
    Very well then I contradict myself,  
### strike through（vs不兼容）

~~It should be deleted~~

### task lists（vs不兼容）
- [x] Completed task
- [ ] Incomplete task  