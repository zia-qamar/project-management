import { Controller } from "stimulus";
import consumer from 'channels/consumer';

export default class extends Controller {
    static targets = ["list", "content"]
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
            if (data.user === parseInt(this.element.dataset.userId)) {
                this.handleError(data.error);
            }
        } else {
            this.handleSuccess(data);
        }
    }

    handleSuccess(data) {
        let newElem = this.templateToElement(data.comment);
        newElem.classList.add('transition', 'duration-500', 'ease-in-out', 'opacity-0');
        this.listTarget.prepend(newElem);

        setTimeout(() => {
            this.contentTarget.value = '';
            let statusDropdown = document.getElementById('status');
            statusDropdown.value = data.status;
            newElem.classList.remove('opacity-0');
        }, 500);
    }

    handleError(errorMessage) {
        this.alertController.showErrorMsg(errorMessage)
    }

    templateToElement(html) {
        let template = document.createElement('template');
        template.innerHTML = html.trim();
        return template.content.firstChild;
    }

    get alertController() {
        return this.application.getControllerForElementAndIdentifier(
            document.getElementById('alert-container'),
            'alerts'
        );
    }
}
