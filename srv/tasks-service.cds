using { sap.todolist as todolist } from '../db/schema';

service TasksService @(path:'/to-do-list') {
    entity Tasks as projection on todolist.Tasks
    excluding { createdBy }
    order by priority desc;

    event statusChanged : {
        status : type of Tasks:status;
    }

    annotate TasksService.Tasks with @restrict:[
        { grant:'READ',   to:'any' },
        { grant:'CREATE', to:'authenticated-user' },
        { grant:['UPDATE', 'DELETE'], to:'authenticated-user', where:'owner = $user' },
        { grant:['UPDATE', 'DELETE'], to:'Admin' },
    ];
}

