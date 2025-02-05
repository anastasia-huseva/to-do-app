const cds = require('@sap/cds');

class TasksService extends cds.ApplicationService {
    init() {
        const { Tasks } = this.entities;

        this.on('DELETE', Tasks, async (req) => {
            const { ID } = req.data;
            await UPDATE(Tasks, ID).set({ status: 4 });
        });

        return super.init();
    }
}

module.exports = TasksService;
