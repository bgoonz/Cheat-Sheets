import React from 'react';
import _ from 'lodash';

import {markdownify} from '../utils';
import FormField from './FormField';

export default class SectionForm extends React.Component {
    render() {
        let section = _.get(this.props, 'section', null);
        return (
            <section id={_.get(section, 'section_id', null)} className="block block-form">
              {_.get(section, 'title', null) && (
              <h2 className="block-title underline inner-sm">{_.get(section, 'title', null)}</h2>
              )}
              <div className="block-content inner-sm">
                {_.get(section, 'content', null) && (
                markdownify(_.get(section, 'content', null))
                )}
                <form name={_.get(section, 'form_id', null)} id={_.get(section, 'form_id', null)} {...(_.get(section, 'form_action', null) ? ({action: _.get(section, 'form_action', null)}) : null)}method="POST" data-netlify="true" data-netlify-honeypot="bot-field">
                  <div className="screen-reader-text">
                    <label>Don't fill this out if you're human: <input name="bot-field" /></label>
                  </div>
                  <input type="hidden" name="form-name" value={_.get(section, 'form_id', null)} />
                  {_.map(_.get(section, 'form_fields', null), (field, field_idx) => (
                    <FormField key={field_idx} {...this.props} field={field} />
                  ))}
                  <div className="form-submit">
                    <button type="submit" className="button">{_.get(section, 'submit_label', null)}</button>
                  </div>
                </form>
              </div>
            </section>
        );
    }
}
