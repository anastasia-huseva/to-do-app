using { sap.todolist as todolist } from '../db/schema';

service TaskService @(path:'/to-do-list') @(requires: 'todoapp.Admin') {
    entity Tasks as select from todolist.Tasks;
}