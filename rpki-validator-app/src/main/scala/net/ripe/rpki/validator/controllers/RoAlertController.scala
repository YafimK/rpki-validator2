package net.ripe.rpki.validator.controllers;
import grizzled.slf4j.Logging
import net.ripe.rpki.validator.models.ValidatedObjects
import net.ripe.rpki.validator.views
import net.ripe.rpki.validator.views.RoAlertView

/**
 * Created by fimka on 23/11/16.
 */
trait RoAlertController extends ApplicationController with Logging{
    private def baseUrl = views.Tabs.RoAlertTab.url;
    protected def validatedObjects: ValidatedObjects

    get(baseUrl) {
        new RoAlertView(validatedObjects)
    }



}
