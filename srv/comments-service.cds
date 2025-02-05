using { sap.todolist as todolist } from '../db/schema';

service CommentsService @(path: '/comments') {
    entity Comments as projection on todolist.Comments;

    event commented : {};
}

annotate CommentsService.Comments with @restrict:[
    { grant:['READ', 'CREATE'],   to:'authenticated-user' },
    { grant:['UPDATE', 'DELETE'], to:'authenticated-user', where:'commenter = $user' },
    { grant:['DELETE'],           to:'Admin' },
];