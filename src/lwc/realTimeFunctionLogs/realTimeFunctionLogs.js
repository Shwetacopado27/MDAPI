import { LightningElement, api, wire } from 'lwc';
import { getRecord, getRecordNotifyChange } from 'lightning/uiRecordApi';
import RESULT_STATUS_FIELD from '@salesforce/schema/copado__Result__c.copado__Status__c';
import LOG_DATA_FIELD from '@salesforce/schema/copado__Result__c.copado__Result_Data__c';
import PROGRESS_STATUS_FIELD from '@salesforce/schema/copado__Result__c.copado__Progress_Status__c';
import LASTMODIFIEDDATE_FIELD from '@salesforce/schema/copado__Result__c.LastModifiedDate';

export default class RealTimeFunctionLogs extends LightningElement {
    @api recordId;
 
    // Wire a record.
    @wire(getRecord, { recordId: '$recordId', fields: [RESULT_STATUS_FIELD, LOG_DATA_FIELD, 
        LASTMODIFIEDDATE_FIELD, PROGRESS_STATUS_FIELD] })
    record;

    firstRenderedCallback=true;
    scrollAreaMarker=null;

    pollingTimeoutId=null;
    pollingStartTime;

    renderedCallback() {
        if(this.firstRenderedCallback) {
            console.log('RealTimeFunctionLogs enter', this.recordId);
            this.firstRenderedCallback = false;
            this.scrollAreaMarker = this.template.querySelector('[data-id="logs"]')
            this.pollingStartTime = (new Date()).getTime();
            this.runPolling();
        }
    }

    disconnectedCallback() {
        console.log('RealTimeFunctionLogs exit');
        if(this.pollingTimeoutId!==null) {
            window.clearTimeout(this.pollingTimeoutId);
        }
    }

    // polling with backoff intervals that will run when the Result record is not finished.
    runPolling() {
        const time = (new Date()).getTime();
        let interval = 0;
        if(time-this.pollingStartTime < 120000) {
            interval = 10000;
        }else if(time-this.pollingStartTime < 600000) {
            interval = 30000;
        }else{
            interval = 60000;
        }
        this.pollingTimeoutId = window.setTimeout( () => {
            getRecordNotifyChange([{recordId: this.recordId}]);
            if(!['In Progress', 'Not Started'].includes(this.getRecordStatus())) {
                console.debug('disabling polling');
                return;
            }
            this.runPolling();
        }, interval);
    }

    handleRecorViewOnload() {
        // scroll to the bottom of the page only if the scroll is already at the bottom
        if(this.elementIsInViewport(this.scrollAreaMarker)) {
            // detach the execution to allow the browser to stabilize
            window.setTimeout( () => {
                this.scrollAreaMarker.scrollIntoView();
            }, 10);
        }
    }

    getRecordStatus() {
        return this.record?.data?.fields?.copado__Status__c?.value || '';
    }

    getTime() {
        var today = new Date();
        return String(today.getHours()).padStart(2,'0') 
            + ":" + String(today.getMinutes()).padStart(2,'0')
            + ":" + String(today.getSeconds()).padStart(2,'0');
    }

    elementIsInViewport(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }
}