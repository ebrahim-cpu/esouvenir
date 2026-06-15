using System;
using System.Text;
using System.Collections;
using System.DirectoryServices;
using System.Web;

namespace FormsAuth
{
    public class LdapAuthentication
    {
        private String _path;
        // private String _filterAttribute;
        public LdapAuthentication(String path)
        {
            _path = path;
        }
        public bool IsAuthenticated(String domain, String NamaPengguna, String pwd)
        {
            String domainDgnNamaPengguna = domain + @"\" + NamaPengguna;
            DirectoryEntry masuk = new DirectoryEntry(_path, domainDgnNamaPengguna, pwd);
            try
            {//Bind to the native AdsObject to force authentication.
                Object obj = masuk.NativeObject;
                DirectorySearcher carian = new DirectorySearcher(masuk)
                {
                    Filter = "(SAMAccountName=" + NamaPengguna + ")"
                };
                carian.PropertiesToLoad.Add("displayName");
                //carian.PropertiesToLoad.Add("mail");
                SearchResult jumpa = carian.FindOne();
                if (null == jumpa)
                {
                    return false;
                }
                _path = jumpa.Path;// LDAP:/KHTP/CN=Ibrahim Bin Ahmad, OU=General KTPC,DC=KHTP,DC=COM,DC=MY
                // _filterAttribute = (String)jumpa.Properties["displayName"][0]; // Ibrahim Bin Ahmad
                HttpContext.Current.Session["Username"] = NamaPengguna;
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }
    }
}