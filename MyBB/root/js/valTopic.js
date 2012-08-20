//select a element with id "id"

function validate(fld) 
{
    var title = trim(fld.title.value);
    var content = trim(fld.description.value);
    var err = ""; 
    if(title == "")
    {
        err += "Title must not empty!\n";
        fld.title.style.background = 'Yellow';
    }
    if(content == "")
    {
        err += "Content must not empty!";
        fld.description.style.background = 'Yellow';
    }
    if(err)
    {
        alert(err);
        return false;
    }
    return true;
}

function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
} 

