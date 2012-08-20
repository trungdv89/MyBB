//select a element with id "id"

function validateFormOnSubmit(theForm) 
{
    var reason = "";
    reason += validateUsername(theForm.username);
    reason += validatePassword(theForm.pwd);
    reason += validateEmail(theForm.email);    
    if (reason != "") 
    {
        alert("Some fields need correction:\n" + reason);
        return false;
    }
    return true;
}

function validateUsername(fld) {
    var error = "";
    var illegalChars = /\s/;
    if (trim(fld.value) == "") {
        fld.style.background = 'Yellow'; 
        error = "You didn't enter a username.\n";
    } else if (illegalChars.test(fld.value)) {
        fld.style.background = 'Yellow'; 
        error = "The username can not contains space character.\n";
    } else {
        fld.style.background = 'White';
    } 
    return error;
}

function validatePassword(fld) {
    var error = "";
    var illegalChars = /[\W_]/; // allow only letters and numbers 
 
    if (fld.value == "") {
        fld.style.background = 'Yellow';
        error = "You didn't enter a password.\n";
    } else if ((fld.value.length < 3) || (fld.value.length > 15)) {
        error = "The password is the wrong length(3-15 characters). \n";
        fld.style.background = 'Yellow';
    } else if (illegalChars.test(fld.value)) {
        error = "The password contains illegal characters.\n";
        fld.style.background = 'Yellow';
    } else {
        fld.style.background = 'White';
    }
   return error;
}  

function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
} 

function validateEmail(fld) {
    var error="";
    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
    
    if (fld.value == "") {
        fld.style.background = 'Yellow';
        error = "You didn't enter an email address.\n";
    } else if (!emailFilter.test(tfld)) {              //test email for illegal characters
        fld.style.background = 'Yellow';
        error = "Please enter a valid email address.\n";
    } else if (fld.value.match(illegalChars)) {
        fld.style.background = 'Yellow';
        error = "The email address contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;
}
