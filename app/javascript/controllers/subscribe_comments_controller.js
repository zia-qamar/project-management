import { Controller } from 'stimulus';
import consumer from 'channels/consumer';

export default class extends Controller {
    static targets = ['status', 'progressPercentage'];

    connect() {
        this.subscription = consumer.subscriptions.create(
            {
                channel: 'CommentsChannel',
                project_id: this.element.dataset.projectId
            },
            {
                connected: {},
                disconnected: {},
                received: this._received.bind(this)
            }
        );
    }

    disconnect() {
        this.subscription.unsubscribe();
    }

    _received(data) {
        if (data.error !== undefined) {
            this.handleError(data.error);
        } else {
            this.handleSuccess(data);
        }
    }

    handleSuccess(data) {
        console.log("error")
        // this.progressPercentageTarget.dataset.progress = progress;
        // this.statusTarget.textContent = `${data.count} of ${data.total}`;
    }

    handleError(errorMessage) {
        console.log("error")
    }
}
