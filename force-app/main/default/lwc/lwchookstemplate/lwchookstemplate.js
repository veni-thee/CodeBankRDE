/**
 * lwchookstemplate.js
 * 
 * Skeleton LWC JavaScript file demonstrating the lifecycle hooks of a Lightning Web Component.
 * 
 * Lifecycle hooks are special methods in LWC that allow developers to run specific logic
 * during different phases of the component's lifecycle.
 */

import { LightningElement, api, track } from 'lwc';

// Import templates
import defaultTemplate from './lwchookstemplate.html';
import alternateTemplate from './lwchookstemplate_alt.html';

export default class Lwchookstemplate extends LightningElement {
    // Reactive properties
    @api publicProperty; // Public property exposed to parent components
    @track trackedProperty = ''; // Reactive property for internal state
    @track isDefaultTemplate = true; // Tracks which template to render

    /**
     * Constructor
     * - Invoked when the component instance is created.
     * - Use this to initialize state or bind methods.
     */
    constructor() {
        super();
        console.log('Component constructed');
    }

    /**
     * Connected Callback
     * - Invoked when the component is inserted into the DOM.
     * - Use this to fetch data, set up event listeners, or perform setup tasks.
     */
    connectedCallback() {
        console.log('Component connected to the DOM');
    }

    /**
     * Rendered Callback
     * - Invoked each time the component's template is rendered.
     * - Use this to interact with the DOM or perform operations after rendering.
     */
    renderedCallback() {
        console.log('Component template rendered');
    }

    /**
     * Render
     * - Customizes the rendering logic for the component.
     * - Returns the template file to be used for rendering the component.
     * - If not overridden, the default template (lwchookstemplate.html) is used.
     * 
     * @returns {Template} - The HTML template to render.
     */
    render() {
        console.log('Custom render logic executed');
        return super.render(); // Default rendering logic
         /**
         * Render
         * - Dynamically chooses the template based on isDefaultTemplate.
         */
        return this.isDefaultTemplate ? defaultTemplate : alternateTemplate;
    }

    /**
     * Toggles the template when the button is clicked.
     */
    toggleTemplate() {
        this.isDefaultTemplate = !this.isDefaultTemplate;
    }

    /**
     * Disconnected Callback
     * - Invoked when the component is removed from the DOM.
     * - Use this to clean up resources, such as event listeners or intervals.
     */
    disconnectedCallback() {
        console.log('Component disconnected from the DOM');
    }

    /**
     * Error Callback
     * - Invoked when an error is thrown during rendering or other lifecycle methods.
     * - Use this to handle errors and gracefully recover.
     * 
     * @param {Error} error - The error that was thrown
     * @param {String} stack - The stack trace of the error
     */
    errorCallback(error, stack) {
        console.error('Error in component', error, stack);
    }

    /**
     * Wire Service (Optional)
     * - If using wire decorators, lifecycle management will also apply for those.
     * - Example:
     *   @wire(someService)
     *   wiredData;
     */
}
