using { managed, User } from '@sap/cds/common';
namespace sap.todolist;

type Priority : Integer @assert.range enum { 
    low = 1;
    medium = 2;
    high = 3;
}
type Status : Integer @assert.range enum { 
    pending = 1;
    in_progress = 2;
    completed = 3;
    deleted = 4;
}

entity Tasks : managed {
    key ID   : UUID;
    title    : String @mandatory;
    desc     : String;
    priority : Priority default 1;
    status   : Status default 1;
    owner    : User;
    comments : Composition of many Comments on comments.subject = $self;
    dueDate  : DateTime;
    countOfComments : Integer default 0;
}

entity Comments : managed {
    key ID    : UUID;
    text      : String @mandatory;
    commenter : User;
    subject   : Association to Tasks;
}

annotate Tasks with {
    owner @cds.on:{insert:$user};
}

annotate Comments with {
    commenter @cds.on:{insert:$user};
}

