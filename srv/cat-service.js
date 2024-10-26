const cds = require('@sap/cds');
const axios = require('axios');

/* module.exports = cds.service.impl(async function() {
    const { ExternalData, foo, say } = this.entities;

    console.log(`klab: ${this.entities}`);

    // Handle READ for ExternalData
    this.on('READ', ExternalData, async () => {
        try {
            const response = await axios.get('https://raw.githubusercontent.com/SAP/abap-atc-cr-cv-s4hc/main/src/objectReleaseInfo_PCE2023_1.json');
            return response.data.objectReleaseInfo;
        } catch (error) {
            throw new Error('Error fetching ExternalData: ' + error.message);
        }
    });

    // Handle READ for foo
    this.on('READ', foo, async () => {
        // Return static or separate data for foo, not related to ExternalData
        return [{ ID: 1 }, { ID: 2 }, { ID: 3 }]; // Example data for foo
    });

    // Handle hello function for say service
    this.on('hello', req => {
        return `Hello ${req.data.to}`;
    });
});
 */



class CatalogService extends cds.ApplicationService {
    init(){
        const { API2022 } = this.entities;

         // Adding CORS Middleware
         cds.on('bootstrap', app => {
            app.use((req, res, next) => {
                const origin = req.headers.origin;
                if (process.env.NODE_ENV !== 'production' && origin) {
                    res.setHeader('Access-Control-Allow-Origin', origin);
                    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, x-csrf-token');
                    res.setHeader('Access-Control-Allow-Methods', 'GET,HEAD,PUT,PATCH,POST,DELETE');
                    if (req.method === 'OPTIONS') {
                        return res.status(204).end();
                    }
                }
                next();
            });
        });


        
        this.on('READ', API2022, async () => {
            try {
                const response = await axios.get('https://raw.githubusercontent.com/SAP/abap-atc-cr-cv-s4hc/main/src/objectReleaseInfo_PCE2023_1.json');
                return response.data.objectReleaseInfo;
            } catch (error) {
                throw new Error('Error fetching ExternalData: ' + error.message);
            }
        });


        
        return super.init();
    }
}

module.exports = CatalogService