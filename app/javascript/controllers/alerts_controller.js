import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['successContainer', 'errorContainer'];

    showErrorMsg(message) {
        this.errorContainerTarget.classList.remove('hidden')
        this.errorContainerTarget.textContent = message
        setTimeout(() => {
            this.errorContainerTarget.classList.add('hidden')
        }, 2500);

    }

    showSuccessMsg(message) {
        this.successContainerTarget.classList.remove('hidden')
        this.successContainerTarget.textContent = message
        setTimeout(() => {
            this.successContainerTarget.classList.add('hidden')
        }, 2500);
    }
}
