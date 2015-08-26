var Person = function(firstname, lastname) 
{
    this.firstname = firstname;
    this.lastname = lastname;
}

function logPerson(person) 
{
    console.log(person);
}

var felipe = new Person('Felipe','Simoes');
logPerson(felipe);