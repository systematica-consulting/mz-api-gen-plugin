/*   Copyright 2004 The Apache Software Foundation
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package sx.microservices.xsd2inst;

import org.apache.xmlbeans.*;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

public class SchemaInstanceGenerator
{
    public static class Xsd2InstOptions
    {
        private boolean _downloads = false;
        private boolean _nopvr = false;
        private boolean _noupa = false;

        /**
         * @return true if network downloads are allowed, false othervise
         * Default is false.
         */
        public boolean isNetworkDownloads()
        {
            return _downloads;
        }

        /**
         * set true to allow network downloads, false othervise
         */
        public void setNetworkDownloads(boolean downloads)
        {
            this._downloads = downloads;
        }

        /**
         * @return true to disable particle valid (restriction) rule, false othervise
         * Default is false.
         */
        public boolean isNopvr()
        {
            return _nopvr;
        }

        /**
         * set true to disable particle valid (restriction) rule, false othervise
         */
        public void setNopvr(boolean nopvr)
        {
            this._nopvr = nopvr;
        }

        /**
         * @return true to disable unique particle attribution rule, false othervise
         * Default is false.
         */
        public boolean isNoupa()
        {
            return _noupa;
        }

        /**
         * set true to disable unique particle attribution rule, false othervise
         */
        public void setNoupa(boolean noupa)
        {
            this._noupa = noupa;
        }
    }


    public static XmlInstance xsd2inst(String[] xsds, String rootName, Xsd2InstOptions options)
        throws XmlException, IOException
    {
        Reader[] instReaders = new Reader[xsds.length];
        for (int i=0; i< xsds.length; i++)
        {
            instReaders[i] = new StringReader(xsds[i]);
        }

        return xsd2inst(instReaders, rootName, options);
    }


    public static XmlInstance xsd2inst(Reader[] schemaReaders, String rootName, Xsd2InstOptions options)
    {
        // Process Schema files
        List sdocs = new ArrayList();
        for (int i = 0; i < schemaReaders.length; i++)
        {
            try
            {
                sdocs.add(XmlObject.Factory.parse(schemaReaders[i],
                        (new XmlOptions()).setLoadLineNumbers().setLoadMessageDigest()));
            }
            catch (Exception e)
            {
                System.err.println("Can not load schema reader: " + i + "  " + schemaReaders[i] + ": ");
                e.printStackTrace();
            }
        }

        XmlObject[] schemas = (XmlObject[]) sdocs.toArray(new XmlObject[sdocs.size()]);

        return xsd2inst(schemas, rootName, options);
    }


    public static XmlInstance xsd2inst(XmlObject[] schemas, String rootName, Xsd2InstOptions options)
    {
        SchemaTypeSystem sts = null;
        if (schemas.length > 0)
        {
            Collection errors = new ArrayList();
            XmlOptions compileOptions = new XmlOptions();
            if (options.isNetworkDownloads())
                compileOptions.setCompileDownloadUrls();
            if (options.isNopvr())
                compileOptions.setCompileNoPvrRule();
            if (options.isNoupa())
                compileOptions.setCompileNoUpaRule();

            try
            {
                sts = XmlBeans.compileXsd(schemas, XmlBeans.getBuiltinTypeSystem(), compileOptions);
            }
            catch (Exception e)
            {
                if (errors.isEmpty() || !(e instanceof XmlException))
                    e.printStackTrace();

                System.out.println("Schema compilation errors: ");
                for (Iterator i = errors.iterator(); i.hasNext(); )
                    System.out.println(i.next());
            }
        }

        if (sts == null)
        {
            throw new RuntimeException("No Schemas to process.");
        }
        SchemaType[] globalElems = sts.documentTypes();
        SchemaType elem = null;
        for (int i = 0; i < globalElems.length; i++)
        {
            if (rootName.equals(globalElems[i].getDocumentElementName().getLocalPart()))
            {
                elem = globalElems[i];
                break;
            }
        }

        if (elem == null)
        {
            throw new RuntimeException("Could not find a global element with name \"" + rootName + "\"");
        }

        // Now generate it
        return SampleXmlUtil.createSampleForType(elem);
    }
}
