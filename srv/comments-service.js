const cds = require('@sap/cds');

class CommentsService extends cds.ApplicationService {
    init() {
        const { Comments } = this.entities;
        const { Tasks } = cds.entities;

        this.before('CREATE', Comments, async (req) => {
            const { subject_ID: taskID } = req.data;
            const task = await SELECT.from(Tasks, taskID);

            if (!task) {
                return req.error(404, `Task with id ${taskID} not found`);
            }
        });

        this.before('DELETE', Comments, async (req) => {
            const { ID } = req.data;
            const comment = await SELECT.one.from(Comments, ID);

            if (!comment) {
                return req.error(404, `Comment with id ${ID} not found`);
            }

            const { subject_ID } = comment;
            req.data.subject_ID = subject_ID;
        });

        this.after(['CREATE', 'DELETE'], Comments, async (_, req) => {
            const { subject_ID: taskID } = req.data;

            await this.emit('commented', { taskID });
        });

        this.on('commented', async (req) => {
            const { taskID } = req.data;
            const comments =
                await SELECT`COUNT(*) FROM Comments WHERE subject_ID=${taskID}`;

            console.log('Count of comments', comments);

            await UPDATE(Tasks, taskID).set({
                countOfComments: comments[0].COUNT,
            });
        });

        return super.init();
    }
}

module.exports = CommentsService;
