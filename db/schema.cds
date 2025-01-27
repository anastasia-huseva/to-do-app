using { managed } from '@sap/cds/common';
namespace sap.todolist;

entity Tasks : managed {
    key ID : Integer;
    title : String;
    desc : String;
}