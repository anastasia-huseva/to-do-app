using { sap.todolist as todolist } from '../db/schema';

service TaskService @(path:'/to-do-list') @(requires: 'Admin') {
    entity Tasks as select from todolist.Tasks;
}