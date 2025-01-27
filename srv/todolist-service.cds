using { sap.todolist as todolist } from '../db/schema';

service TaskService @(path:'/to-do-list') {
    entity Tasks as select from todolist.Tasks;
}