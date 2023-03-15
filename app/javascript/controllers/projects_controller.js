import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {

    updateStatus(event) {
        const projectId = this.data.get("project-id")
        const status = event.target.value

        Rails.ajax({
            type: "PUT",
            url: `/projects/${projectId}/update_status`,
            data: `status=${status}`,
            success: (data) => {
                this.alertController.showSuccessMsg(data.msg);
            },
            error: (data) => {
                this.alertController.showErrorMsg(data.error);
            }
        })
    }

    get alertController() {
        return this.application.getControllerForElementAndIdentifier(
            document.getElementById('alert-container'),
            'alerts'
        );
    }
}
