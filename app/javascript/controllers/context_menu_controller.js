import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['menu'];

    disconnect() {
        document.removeEventListener('click', this.handleBackgroundClick);
    }

    handleBackgroundClick = e => {
        if (!(e.target === this.menuTarget || this.menuTarget.contains(e.target))) {
            this.hideDrop();
        }
    };

    toggle() {
        this.menuTarget.classList.contains('c-context-menu--open')
            ? this.hideDrop()
            : this.showDrop();
    }

    showDrop() {
        this.menuTarget.classList.add('c-context-menu--open');
        document.addEventListener('click', this.handleBackgroundClick);
    }

    hideDrop() {
        this.menuTarget.classList.remove('c-context-menu--open');
        document.removeEventListener('click', this.handleBackgroundClick);
    }
}
