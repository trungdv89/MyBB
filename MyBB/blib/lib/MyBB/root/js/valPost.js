//select a element with id "id"

function validateConfirm(fld) 
{
    var tfld = trim(fld.value); 
    if(tfld == "")
    {
        alert("Content must not empty!");
        return false;
    }
    else
    {
        return confirm("Are you sure");
    }
}

function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
} 

